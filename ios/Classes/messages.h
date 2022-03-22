// Autogenerated from Pigeon (v2.0.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IRIRInstallationType) {
  IRIRInstallationTypeAppStore = 0,
  IRIRInstallationTypeTest = 1,
  IRIRInstallationTypeDebug = 2,
  IRIRInstallationTypeUnknown = 3,
};

typedef NS_ENUM(NSUInteger, IRIRInstallationPlatform) {
  IRIRInstallationPlatformAppleAppStore = 0,
  IRIRInstallationPlatformAppleTestflight = 1,
  IRIRInstallationPlatformGooglePlay = 2,
  IRIRInstallationPlatformAmazonAppStore = 3,
  IRIRInstallationPlatformSamsungAppShop = 4,
  IRIRInstallationPlatformManually = 5,
  IRIRInstallationPlatformUnknown = 6,
};

@class IRIRInstallationReferer;

@interface IRIRInstallationReferer : NSObject
+ (instancetype)makeWithType:(IRIRInstallationType)type
    platform:(IRIRInstallationPlatform)platform;
@property(nonatomic, assign) IRIRInstallationType type;
@property(nonatomic, assign) IRIRInstallationPlatform platform;
@end

/// The codec used by IRInstallReferrerInternalAPI.
NSObject<FlutterMessageCodec> *IRInstallReferrerInternalAPIGetCodec(void);

@protocol IRInstallReferrerInternalAPI
- (void)detectReferrerWithCompletion:(void(^)(IRIRInstallationReferer *_Nullable, FlutterError *_Nullable))completion;
@end

extern void IRInstallReferrerInternalAPISetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<IRInstallReferrerInternalAPI> *_Nullable api);

NS_ASSUME_NONNULL_END
