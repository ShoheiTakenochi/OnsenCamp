# サービス名: OnsenCamp
## サービス概要
- キャンプ場を検索すると最寄りの温泉施設(半径○○km以内)を表示します
- それによりキャンプと温泉を両方楽しめるプランを考えることが出来ます

## 開発背景
私はもともと温泉に入るのが好きで、趣味のキャンプに行く際は、近くに温泉がないかを毎回探しておりました。まずはキャンプ場を決めてから、その後に最寄りの気になる温泉を別途探して、スケジュールを考えておりました。

このキャンプ場探しと、温泉探しを一緒くたに出来れば、キャンプの計画を立てるのがより便利になり、楽しくなると考え、政策を決めました。

## ターゲットについて
- キャンプが趣味の方
- 温泉が好きな方

## サービスの利用イメージ
 - ユーザーは検索フォームに行きたいキャンプ場を検索します
 - 検索後mapが対象の施設に拡大されます
 - 拡大後該当のキャンプ場を中心に最寄りの温泉施設がmap上に表示されます
 - MAP上の下には温泉施設の情報が近い順表示されます


##  ユーザーの獲得について
- Xによる宣伝
- ソーシャルポートフォリオへの掲載
- RUNTEQコミュニティのtimesなどに掲載
## サービスの差別化ポイント・推しポイント
キャンプ場検索サイトの「ナップ」等でも、「温泉が楽しめるキャンプ場」という検索方法が用意されておりますが、あくまで「温泉施設がキャンプ場に含まれるキャンプ場」というくくりに限定されるため、かなり限定的なものになります。

◆差別化ポイント
- 目的に特化したサービス設計
  - 一般的な Google Maps との違い:
    - Google Maps でキャンプ場を検索 → 近くの温泉を手動で探す → 一つずつ確認する手間がかかる
    - OnsenCamp では「キャンプ場を検索するだけで温泉施設がリスト＆マップで即座に表示」されるため、検索の手間が大幅に減る
    - 一つずつ検索せずとも、キャンプ場の周辺にどれだけ温泉施設があるか「視覚的に」把握しやすい
  - 温泉好きキャンパー向けの特化機能
    - Google Maps では「温泉施設の情報」は出るが、「キャンプ場とセットで表示」はされない
    - OnsenCamp では、キャンプ場との距離・アクセス・おすすめ情報をまとめて確認できる
    - 追加検討中機能:
      - 温泉施設ごとの キャンパー向け情報（例：深夜営業の有無・駐車場の有無・キャンプ場からの距離ランキング）
      - 「サウナ付き」「露天風呂あり」などのフィルター機能

## 実装機能
- MVP
  - ユーザー登録・ログイン
    - ユーザー名, パスワード
  - お気に入り機能(一覧の表示、追加、削除)
    - キャンプ場をお気に入りリストに保存できる
  - キャンプ場検索機能
    - 名前検索(マルチ検索・オートコンプリート)
    - 地図表示機能(Google Maps Platform)
-  本リリース
  - 温泉施設ごとのキャンパー向け情報(例：深夜営業の有無、駐車場の有無等)
  - 温泉施設の「サウナ付き」「露天風呂あり」などのフィルター機能

## 機能の実装方針予定
- 地図表示機能 (Google Maps API)
  - 実装方法:
    - フロントエンドで Google Maps JavaScript API を利用
    - ユーザーがキャンプ場を検索したら、その地点を中心に温泉施設を表示
  - API/Gem:
    - google_maps_service (Google Maps API)
    - Google Places API を活用し、近くの温泉情報を取得
- 最寄りの温泉施設の表示
  - 実装方法:
    - Google Places API を使い、「温泉」「スパ」カテゴリで検索
    - 指定したキャンプ場の座標をもとに、半径〇km内の温泉施設を取得
    - 検索結果をリスト表示＋地図上にマーカーを追加
  - API/Gem:
    - google_places (Googleの施設情報取得)

## 画面推移図

https://www.figma.com/design/EmxAvAyLwdunERz1j7JoFt/OnsenCamp?node-id=0-1&p=f&t=VKO4DVq8QXSKK0lp-0

## ER図

[![Image from Gyazo](https://i.gyazo.com/ad69cffe5b921fd43c01e1e77fcbf887.png)](https://gyazo.com/ad69cffe5b921fd43c01e1e77fcbf887)

- 各テーブルの解説
 - usersテーブル：基本的なユーザー情報用のテーブル

 - favoritesテーブル：お気にいり機能に必要なテーブル

 - campsitesテーブル：キャンプ場閲覧等に必要な情報を保存
  -name:キャンプ場の名前
  -address:キャンプ場の住所
  -latitude:キャンプ場の緯度
  -longitude:キャンプ場の経度

 - hotspringsテーブル：温泉施設閲覧等に必要な情報を保存
  -name:温泉施設の名前
  -address:温泉施設の住所
  -latitude:温泉施設の緯度
  -longitude:温泉施設の経度
  -late_night_open:深夜営業の有無(本リリース時に実装予定のフィルター機能用)
  -parking:駐車場の有無(本リリース時に実装予定のフィルター機能用)
  -sauna:サウナの有無(本リリース時に実装予定のフィルター機能用)
  -open_air_bath:露天風呂の有無(本リリース時に実装予定のフィルター機能用)
 
 - campsite_hotspringsテーブル
  -キャンプ場と温泉の中間テーブル
