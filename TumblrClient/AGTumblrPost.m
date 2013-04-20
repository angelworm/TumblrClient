//
//  AGTumblrElement.m
//  TumblrClient
//
//  Created by 中島 進 on 2013/04/20.
//  Copyright (c) 2013年 Angelworm. All rights reserved.
//

#import "AGTumblrPost.h"

@implementation AGTumblrPost

@synthesize content;
@synthesize url, type, postID, tumblelogKey, reblogKey, source;

-(id)initWithXMLDocument:(NSXMLElement*)dom
{
    self = [super init];
    if(self) {
        self.domtree = dom;

        self.postID = [[dom attributeForName:@"data-post-id"] stringValue];
        self.tumblelogKey = [[dom attributeForName:@"data-tumblelog-key"] stringValue];
        self.reblogKey = [[dom attributeForName:@"data-reblog-key"] stringValue];
        self.type = [[dom attributeForName:@"data-type"] stringValue];
        
        NSArray *sourceList = [dom nodesForXPath:@".//span[@class=\"source_url\"]/a" error:nil];
        if([sourceList count] > 0) {
            self.source = [[[sourceList objectAtIndex:0] attributeForName:@"href"] stringValue];
        } else {
            self.source = nil;
        }
        
        NSArray *permalinkList = [dom nodesForXPath:@".//a[@class=\"permalink\"]" error:nil];
        if([permalinkList count] > 0) {
            self.url = [[[permalinkList objectAtIndex:0] attributeForName:@"href"] stringValue];
        } else {
            self.url = nil;
        }
        
        NSArray *cotents = [dom nodesForXPath:@".//div[@class=\"post_wrapper\"]" error:nil];
        if([permalinkList count] > 0) {
            self.content = [cotents objectAtIndex:0];
        } else {
            self.content = dom;
        }

    }
    return self;
}

+ (NSArray *)elementsWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *res;
    NSError *err;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&res
                                                     error:&err];
    
    if(!data) {
        NSLog(@"Error:%@", [err domain]);
        return @[];
    }

    NSXMLDocument *document = [[NSXMLDocument alloc] initWithXMLString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]
                                                               options:NSXMLDocumentTidyHTML
                                                                 error:&err];
    NSString *xpathQueryString = @"//ol[@id=\"posts\"]/li[@id][not(position()=1)]";
    NSArray  *posts = [[document rootElement] nodesForXPath:xpathQueryString error:nil];
    
    NSMutableArray *ret = [NSMutableArray array];
    for(id post in posts) {
        [ret addObject:[[AGTumblrPost alloc] initWithXMLDocument:post]];
    }
    return [NSArray arrayWithArray:ret];
}

+ (NSArray *)elements
{
    return [AGTumblrPost elementsWithURL:[NSURL URLWithString:@"http://tumblr.com"]];
}

+ (NSArray *)elementsWithPage:(int)page
{
    return [AGTumblrPost elementsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tumblr.com/dasboard/%d", page]]];
}


-(NSString *)renderHTML
{
    return [self.content XMLString];
}

@end
