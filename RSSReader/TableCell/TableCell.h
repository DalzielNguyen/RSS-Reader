//
//  TableCell.h
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <Foundation/Foundation.h>
@interface TableCell : NSObject
@property (strong,nonatomic) NSString *strTitle;
@property (strong,nonatomic) NSString *strTime;
@property (strong,nonatomic) NSString *strDescription;
-(instancetype) initWithDictionary:(NSDictionary *)dic;
@end

