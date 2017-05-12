# APNSNotify
IOS AWS remote notification

Tutorial:
part 1
https://medium.com/aws-activate-startup-blog/a-guide-to-amazon-simple-notification-service-mobile-push-self-registration-for-ios-f85d114d42b8
part 2
https://medium.com/aws-activate-startup-blog/a-guide-to-amazon-simple-notification-service-mobile-push-self-registration-for-ios-a2502e8d5fbd

create endpoint
https://www.adamtootle.com/blog/2014/10/27/ios-push-notifications-registration-using-aws/

Providing AWS Credentials
https://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth-aws-identity-for-ios.html

Set service configuration to create endpoint register
https://github.com/awslabs/aws-sdk-ios-samples/blob/master/SNS-MobileAnalytics-Sample/Objective-C/SNS_MobileAnalytics_Sample/Info.plist
![2](https://cloud.githubusercontent.com/assets/8034605/25995906/c63b20d6-3714-11e7-836b-0f8361762c32.PNG)

or set in code reference in Tutorial

app for testing remote notification
https://github.com/stefanhafeneger/PushMeBaby

Remember to change the .cer file and the device Token

AWS configuration
![capture](https://cloud.githubusercontent.com/assets/8034605/25996008/458f0b90-3715-11e7-945a-cf75c1657a7f.PNG)
upload certificate download from https://developer.apple.com/
