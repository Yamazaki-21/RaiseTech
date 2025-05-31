# Railsアプリケーションのインフラ構築とデプロイの自動化
本リポジトリは、AWS上にRailsアプリケーションの実行環境を自動構築し、効率的かつ確実に運用するためのインフラ構築およびデプロイの実践的な手法を記録する。

## ■自動化の全体フロー
### ◯自動構築の流れ
Gitリポジトリへのpushをトリガーに、CircleCIが一連の処理を自動で実行する。以下のステップにより、インフラ構築からアプリケーションのデプロイ、動作検証までを一括して行う。
1. AWSリソースのプロビジョニング<br>
   CloudFormation によって、VPC、ALB、EC2、RDS、S3などの AWSリソース(スタック)を構築する。
2. Railsアプリのデプロイ環境構築<br>
   Ansibleにより、Rails実行環境(各種ミドルウェアや依存パッケージ)を構成する。
3. サーバー構成のテスト<br>
   Serverspec によって、構成されたサーバーが要件どおりに動作するかを検証する。


### ◯ 構成図
下記の図は、本リポジトリで構築する環境の全体構成である。
![構成図](./diagram/rails-app-automation-architecture.png)<br>
[構造図ファイル - rails-app-automation-architecture.drawio](./diagram/rails-app-automation-architecture.drawio)

## ■ 動作環境
### ◯ サンプルアプリケーション
[GitHubリポジトリ - yuta-ushijima/raisetech-live8-sample-app](https://github.com/yuta-ushijima/raisetech-live8-sample-app)

### ◯ 使用技術
| 項目       | バージョン   |
|------------|--------------|
| Ruby       | 3.2.3        |
| Bundler    | 2.3.14       |
| Rails      | 7.1.3.2      |
| Node.js    | v17.9.1      |
| Yarn       | 1.22.19      |

### ◯ ミドルウェア・ストレージ
| 種別                     | 項目            |
|--------------------------|--------------------|
| Webサーバー              | Nginx               |
| アプリケーションサーバー  | Puma                 |
| データベース             | Amazon RDS for MySQL |
| ストレージ               | Amazon S3           |


## ■ 学習記録
| No. | 学習内容                        | 課題内容                                                               | 提出物                                 |
|-----|---------------------------------|------------------------------------------------------------------------|----------------------------------------|
| 1   | インフラ基礎・AWS概要           | AWSアカウント作成、IAM設定、Rubyスクリプト実行                        | Discordにて提出                         |
| 2   | Git・Markdown                  | GitHubアカウント作成、Markdownで授業の感想を記述しPR提出               | [lecture02.md](./lecture02.md)         |
| 3   | Webアプリの構成と開発の流れ    | Cloud9にRailsアプリをデプロイ、利用中のAPサーバーやDBを調査           | [lecture03.md](./lecture03/lecture03.md) |
| 4   | AWS基礎リソースの作成          | VPC、EC2、RDS を構築し、EC2 から RDS に接続できるか確認               | [lecture04.md](./lecture04/lecture04.md) |
| 5   | 負荷分散とS3の利用             | ALBを用いた負荷分散構成、S3への画像保存、インフラ構成図の作成         | [lecture05.md](./lecture05/lecture05.md) |
| 6   | ロギング・監視・コスト管理     | CloudTrailイベント確認、CloudWatchアラーム通知設定、AWS料金見積もり   | [lecture06.md](./lecture06/lecture06.md) |
| 7   | セキュリティの基礎             | 現在の構成の脆弱性を洗い出し、対策を検討                               | [lecture07.md](./lecture07/lecture07.md) |
| 8   | 環境構築の実演①                | -                                                                      | なし                                    |
| 9   | 環境構築の実演②                | -                                                                      | なし                                    |
| 10  | インフラ構成のコード化         | AWS構成をCloudFormationテンプレート化して再構築                        | [lecture10.md](./lecture10/lecture10.md) |
| 11  | インフラテスト（Serverspec）   | ServerSpecを使って構成が正しいかを自動テスト                           | [lecture11.md](./lecture11/lecture11.md) |
| 12  | CI/CDとTerraformの基礎         | CircleCI導入と基本的なジョブの動作検証                                 | [lecture12.md](./lecture12/lecture12.md) |
| 13  | 自動化パイプライン構築         | CircleCIでCloudFormation → Ansible → Serverspecを自動実行              | [lecture13.md](./lecture13/lecture13.md) |
| 14  | 環境構築の実演③                | -                                                                      | なし                                    |
| 15  | 環境構築の実演④                | -                                                                      | なし                                    |
| 16  | 現場で活きるスキルの整理       | 就職・転職を見据えた知識の整理と振り返り                               | なし                                    |
