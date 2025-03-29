require "open-uri"
require 'aws-sdk-s3' # AWS SDKを追加

namespace :fetch do
  desc "Migrate existing campsite images from local storage to Active Storage on S3"
  task :migrate_images_to_s3 => :environment do
    s3_bucket_name = ENV['S3_BUCKET_NAME']
    s3_region = ENV['AWS_REGION']
    s3_client = Aws::S3::Client.new(region: s3_region)

    Campsite.find_each do |campsite|
      next if campsite.images.attached?

      photo_paths = JSON.parse(campsite.photo_paths) rescue []

      photo_paths.each do |path|
        s3_key = path.sub('public/', '').sub('storage/', '') # S3パスに合わせて修正
        s3_url = "https://#{s3_bucket_name}.s3.#{s3_region}.amazonaws.com/#{s3_key}"
        # 画像がS3に存在するか確認
        begin
          s3_client.head_object(bucket: s3_bucket_name, key: s3_key)
          
          # Active Storage の attach を S3 参照として登録
          blob = ActiveStorage::Blob.create_before_direct_upload!(
            key: s3_key,
            filename: File.basename(path),
            content_type: 'image/jpeg',
            byte_size: 1, # ダミーのサイズ（実データは保存しない）
            checksum: Base64.encode64(Digest::MD5.digest("")),
            service_name: "amazon"
          )

          campsite.images.attach(blob)

          puts "✅ #{campsite.name} の画像 #{File.basename(path)} を Active Storage に紐付け完了"
        rescue Aws::S3::Errors::NotFound => e
          # ファイルがS3に見つからなかった場合
          puts "⚠️ エラー: #{campsite.name} の画像 #{File.basename(path)} はS3に存在しませんでした"
        rescue Aws::S3::Errors::Forbidden => e
          # S3バケットにアクセス権がない場合
          puts "⚠️ エラー: #{campsite.name} の画像 #{File.basename(path)} のアップロードに失敗 (403 Forbidden - バケットの権限を確認してください)"
        rescue StandardError => e
          # その他のエラー
          puts "⚠️ エラー: #{campsite.name} の画像 #{File.basename(path)} の処理中にエラーが発生 (#{e.message})"
        end
      end

      if campsite.images.attached?
        campsite.save!
        puts "✅ #{campsite.name} の画像を Active Storage に紐付け完了"
      else
        puts "⏭️ #{campsite.name} は移行対象の画像がありませんでした"
      end
    end

    puts "✨ 全てのキャンプ場の画像の移行処理が完了しました"
  end
end