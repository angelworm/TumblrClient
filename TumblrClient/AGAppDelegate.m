//
//  AGAppDelegate.m
//  TumblrClient
//
//  Created by 中島 進 on 2013/03/02.
//  Copyright (c) 2013年 Angelworm. All rights reserved.
//

#import "AGAppDelegate.h"
#import "AGTumblrPost.h"

@implementation AGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
/*    NSHTTPCookieStorage *cst = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSLog(@"launch:%ld", [[cst cookiesForURL:[NSURL URLWithString:@"http://tumblr.com"] ] count]);
    
    for (NSHTTPCookie *cookie in [cst cookiesForURL:[NSURL URLWithString:@"http://tumblr.com"]]) {
        NSLog(@"%@", [cookie description]);
    }*/
    
    [[self.webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tumblr.com"]]];
    
    NSArray *posts = [AGTumblrPost elementsWithURL:[NSURL URLWithString:@"http://tumblr.com"]];
    NSLog(@"webView:%ld", [posts count]);
    [self.post.mainFrame loadHTMLString:[(AGTumblrPost*)[posts objectAtIndex:0] renderHTML]
                                baseURL:[NSURL URLWithString:@"http://tumblr.com"]];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    //DOMDocument *dom = [frame DOMDocument];
    //DOMNodeList *dls = [dom getElementsByClassName:@"post"];
//    NSLog(@"%@", [[dls item:2] webFrame]);
//    [[[[self.post mainFrame] DOMDocument] body] appendChild:[dls item:2]];
    //[[self.post mainFrame] loadHTMLString:[[dls item:0]  baseURL:@"http://tumblr.com"];
}
@end
