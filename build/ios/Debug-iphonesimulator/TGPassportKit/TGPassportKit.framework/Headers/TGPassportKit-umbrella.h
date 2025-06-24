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

#import "TGPAppDelegate.h"
#import "TGPBotConfig.h"
#import "TGPRequest.h"
#import "TGPScope.h"
#import "TGPUtilities.h"
#import "TGPButton.h"

FOUNDATION_EXPORT double TGPassportKitVersionNumber;
FOUNDATION_EXPORT const unsigned char TGPassportKitVersionString[];

