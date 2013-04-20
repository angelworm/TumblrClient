//
//  AGAppDelegate.h
//  TumblrClient
//
//  Created by 中島 進 on 2013/03/02.
//  Copyright (c) 2013年 Angelworm. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AGAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *webview;
@property (weak) IBOutlet WebView *post;

@end
