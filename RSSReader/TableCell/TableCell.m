//
//  TableCell.m
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import "TableCell.h"

@implementation TableCell
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self.strTitle = [dic objectForKey:@"title"];
    self.strDescription = [dic objectForKey:@"description"];
    self.strTime = [dic objectForKey:@"pubDate"];
    return self;
}
@end

