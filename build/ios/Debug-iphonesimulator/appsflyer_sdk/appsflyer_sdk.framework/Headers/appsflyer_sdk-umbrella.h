#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AppsFlyerAttribution.h"
#import "AppsflyerSdkPlugin.h"
#import "AppsFlyerStreamHandler.h"
#import "FlutterAppDelegate+AppsFlyerStreamHandler.h"

FOUNDATION_EXPORT double appsflyer_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char appsflyer_sdkVersionString[];

