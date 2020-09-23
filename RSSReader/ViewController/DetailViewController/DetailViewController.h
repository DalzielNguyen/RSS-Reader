//
//  DetailViewController.h
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController{
    NSString *StrTitleOfNews;
}
@property (weak, nonatomic) IBOutlet UILabel *TitleOfNew;
@property (weak, nonatomic) IBOutlet UIImageView *ImageOfNews;
@property (weak, nonatomic) IBOutlet UITextView *SortContentOfNews;
@property (weak, nonatomic) IBOutlet UIButton *BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *BtnVisitWebsite;
@property (nonatomic) NSMutableDictionary *curren;
@property (nonatomic) NSString *UrlOfNew;
@property (nonatomic) NSString *sortContent;
@property (nonatomic) NSString *UrlImage;
@end

NS_ASSUME_NONNULL_END
