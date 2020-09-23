//
//  HomeViewController.h
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *arrayData;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@end

NS_ASSUME_NONNULL_END
