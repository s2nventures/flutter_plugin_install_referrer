// Autogenerated from Pigeon (v10.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "Messages.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface IRIRInstallationReferer ()
+ (IRIRInstallationReferer *)fromList:(NSArray *)list;
+ (nullable IRIRInstallationReferer *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation IRIRInstallationReferer
+ (instancetype)makeWithType:(IRIRInstallationType)type
    installationPlatform:(IRIRInstallationPlatform)installationPlatform
    platform:(IRIRPlatform)platform
    packageName:(nullable NSString *)packageName {
  IRIRInstallationReferer* pigeonResult = [[IRIRInstallationReferer alloc] init];
  pigeonResult.type = type;
  pigeonResult.installationPlatform = installationPlatform;
  pigeonResult.platform = platform;
  pigeonResult.packageName = packageName;
  return pigeonResult;
}
+ (IRIRInstallationReferer *)fromList:(NSArray *)list {
  IRIRInstallationReferer *pigeonResult = [[IRIRInstallationReferer alloc] init];
  pigeonResult.type = [GetNullableObjectAtIndex(list, 0) integerValue];
  pigeonResult.installationPlatform = [GetNullableObjectAtIndex(list, 1) integerValue];
  pigeonResult.platform = [GetNullableObjectAtIndex(list, 2) integerValue];
  pigeonResult.packageName = GetNullableObjectAtIndex(list, 3);
  return pigeonResult;
}
+ (nullable IRIRInstallationReferer *)nullableFromList:(NSArray *)list {
  return (list) ? [IRIRInstallationReferer fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.type),
    @(self.installationPlatform),
    @(self.platform),
    (self.packageName ?: [NSNull null]),
  ];
}
@end

@interface IRInstallReferrerInternalAPICodecReader : FlutterStandardReader
@end
@implementation IRInstallReferrerInternalAPICodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [IRIRInstallationReferer fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface IRInstallReferrerInternalAPICodecWriter : FlutterStandardWriter
@end
@implementation IRInstallReferrerInternalAPICodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[IRIRInstallationReferer class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface IRInstallReferrerInternalAPICodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation IRInstallReferrerInternalAPICodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[IRInstallReferrerInternalAPICodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[IRInstallReferrerInternalAPICodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *IRInstallReferrerInternalAPIGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    IRInstallReferrerInternalAPICodecReaderWriter *readerWriter = [[IRInstallReferrerInternalAPICodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void IRInstallReferrerInternalAPISetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<IRInstallReferrerInternalAPI> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.InstallReferrerInternalAPI.detectReferrer"
        binaryMessenger:binaryMessenger
        codec:IRInstallReferrerInternalAPIGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(detectReferrerWithCompletion:)], @"IRInstallReferrerInternalAPI api (%@) doesn't respond to @selector(detectReferrerWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api detectReferrerWithCompletion:^(IRIRInstallationReferer *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
