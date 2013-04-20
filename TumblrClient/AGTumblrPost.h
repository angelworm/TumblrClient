//
//  AGTumblrElement.h
//  TumblrClient
//
//  Created by 中島 進 on 2013/04/20.
//  Copyright (c) 2013年 Angelworm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTumblrPost : NSObject

@property (assign) NSXMLNode *content, *domtree;
@property (assign) NSString  *url, *type, *postID, *tumblelogKey, *reblogKey, *source;

+ (NSArray *)elements;
+ (NSArray *)elementsWithPage:(int)page;
+ (NSArray *)elementsWithURL:(NSURL *)url;

-(id)initWithXMLDocument:(NSXMLDocument*)doc;
-(NSString *)renderHTML;
@end
