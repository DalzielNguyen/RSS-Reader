//
//  SaveViewController.h
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
+(void)ReadData;
+(void)SaveData;
+(void)AddNewsToDownloadPlist:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
