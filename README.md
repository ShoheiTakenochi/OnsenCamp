# サービス名: OnsenCamp
## サービス概要
- キャンプ場を検索すると、周辺10km圏内の温泉施設を同時に表示できるWebアプリです

## デプロイURL
- https://onsencamp.onrender.com

## 開発背景
キャンプ場と温泉施設を別々に検索する手間を解消したいと考え開発しました
従来は下記のような手順でした。
1.キャンプ場を探す
2.地図アプリなどで最寄りの近隣の温泉を検索
3.距離を個別に確認

本アプリでは「キャンプ場を検索するだけで周辺温泉を一覧＋地図表示」できるように設計しました

## 主な機能（実装済み）
 - キャンプ場検索（Google Places API）
 - 地図表示（Google Maps JavaScript API）
 - 10km圏内温泉検索
 - お気に入り機能（追加 / 削除 / 一覧表示）
 - ユーザー登録 / ログイン
 - Googleアカウントログイン

## サービスの差別化ポイント
- 目的に特化したサービス設計
  - 一般的な地図アプリとの違い:
    - 地図アプリでキャンプ場を検索 → 近くの温泉を手動で探す → 一つずつ確認する手間がかかる
    - OnsenCampでは「キャンプ場を検索するだけで温泉施設がリスト＆マップで即座に表示」されるため、検索の手間が大幅に減る。
    -一つずつ検索せずとも、キャンプ場の周辺にどれだけ温泉施設があるか「視覚的に」把握しやすい。
  - 温泉好きキャンパー向けの特化機能
    - 地図アプリでは「温泉施設の情報」は出るが、「キャンプ場とセットで表示」はされない。
    - OnsenCampでは、キャンプ場との距離・アクセスをまとめて確認できます。

## 技術的工夫
- Haversineの公式を用いて緯度経度から距離を算出し、半径10km以内の温泉施設のみを抽出するロジックを実装
-  Devise + OmniAuthを用いたGoogle OAuth認証を実装し、外部認証フローを構築

## 画面推移図

https://www.figma.com/design/EmxAvAyLwdunERz1j7JoFt/OnsenCamp?node-id=0-1&p=f&t=VKO4DVq8QXSKK0lp-0

## ER図

[![Image from Gyazo](https://i.gyazo.com/ad69cffe5b921fd43c01e1e77fcbf887.png)](https://gyazo.com/ad69cffe5b921fd43c01e1e77fcbf887)

- 各テーブルの解説
 - users：ユーザー情報を管理
 - favorites：お気にいり機能を管理
 - campsites：キャンプ場情報
 - hotsprings：温泉施設情報

## 技術スタック
 - Ruby on Rails 7
 - PostgreSQL
 - Docker
 - Render
 - Google Maps Platform
 - Tailwind CSS

 ## 課題と今後の改善点

- Google Places APIの課金仕様変更により画像取得機能を停止
- 外部API依存設計のリスクを学習
- データキャッシュや独自データ保持設計の検討が今後の課題