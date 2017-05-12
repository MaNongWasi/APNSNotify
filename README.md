# APNSNotify
IOS AWS remote notification

Tutorial:
part 1
https://medium.com/aws-activate-startup-blog/a-guide-to-amazon-simple-notification-service-mobile-push-self-registration-for-ios-f85d114d42b8
part 2
https://medium.com/aws-activate-startup-blog/a-guide-to-amazon-simple-notification-service-mobile-push-self-registration-for-ios-a2502e8d5fbd

create endpoint
https://www.adamtootle.com/blog/2014/10/27/ios-push-notifications-registration-using-aws/

create endpoint and subscribe an endpoint to a topic to receive messages published to that topic
stackoverflow.com/questions/26974852/amazon-aws-how-do-i-subscribe-an-endpoint-to-sns-topic

Providing AWS Credentials
https://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth-aws-identity-for-ios.html

Set service configuration to create endpoint register
https://github.com/awslabs/aws-sdk-ios-samples/blob/master/SNS-MobileAnalytics-Sample/Objective-C/SNS_MobileAnalytics_Sample/Info.plist
![2](https://cloud.githubusercontent.com/assets/8034605/25995906/c63b20d6-3714-11e7-836b-0f8361762c32.PNG)

or set in code reference in Tutorial

app for testing remote notification
https://github.com/stefanhafeneger/PushMeBaby

Remember to change the .cer file and the device Token


IOS 10 to enable notification
![1](https://cloud.githubusercontent.com/assets/8034605/25996053/86dd94ae-3715-11e7-9acb-2e12c6f8d2c3.PNG)

TO register AWS SNS with APNS IOS(suitable for testing, in this case, subscription for each device token need to be done one by one):
Set in aws sns web page

1. ![create](https://cloud.githubusercontent.com/assets/8034605/25904330/37275fac-359f-11e7-9612-ded028a8df06.PNG)
2. ![cr1](https://cloud.githubusercontent.com/assets/8034605/25904362/51a8b51a-359f-11e7-82de-5467cb163d5e.PNG)
3. 
Option 1: ![capture](https://cloud.githubusercontent.com/assets/8034605/25996008/458f0b90-3715-11e7-945a-cf75c1657a7f.PNG)
upload certificate download from https://developer.apple.com/
Option 2: Use Code in SNSTestActivity: 'AWSCreateEndpointTask' End Point can be known through result
reference Link: http://www.mobileaws.com/2015/03/25/amazon-sns-push-notification-tutorial-android-using-gcm/
3. ![createtopic](https://cloud.githubusercontent.com/assets/8034605/25943334/cfafdd8a-363f-11e7-9d82-603079d1ab88.PNG)
4. ![topic](https://cloud.githubusercontent.com/assets/8034605/25943315/c7cccba0-363f-11e7-9e8c-fc5693944816.PNG)
5. ![cs2](https://cloud.githubusercontent.com/assets/8034605/25904366/56f428a6-359f-11e7-9bea-3237443cbbe6.PNG)
6. ![sub](https://cloud.githubusercontent.com/assets/8034605/25904376/5c3a52ae-359f-11e7-876d-19a1560e3887.PNG)


