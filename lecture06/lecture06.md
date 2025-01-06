# 第6回課題

### CloudTrailにてイベントをピックアップ
- イベント名：ConsoleLogin<br> 
  - IAMユーザーがAWSコンソールにサインインした時のイベント
- 含まれている内容
   - イベント時間： "eventTime": "2025-01-01T05:08:41Z"
   - イベントソース： "eventSource": "signin.amazonaws.com"
   - AWSリージョン: "awsRegion": "ap-northeast-1"
![](image/image01.png)

### CloudWatch AlarmとSNSを使ったメール通知

- CloudWatchでUnHealthyHostCountのAlarmアクション確認
   - ALBのtargetのヘルスチェックでUnHealthy状態
![](image/image02.png)
   - CloudWatch アラームの状態(アラーム状態)
![](image/image03.png)
   - SNSでのメール受信
![](image/image04.png)

- CloudWatchでUnHealthyHostCountのOKアクション確認
   - ALBのtargetのヘルスチェックがHealthy状態
![](image/image05.png)
   - CloudWatch アラームの状態(OK)
![](image/image06.png)
   - SNSでのメール受信
![](image/image07.png)

### AWS利用料の見積り(URL)
https://calculator.aws/#/estimate?id=dbe7a538564a74bb81183bae7b7e54cfbc0ea970

### 2024年12月の利用料(EC2の利用料)
![](image/image08.png)