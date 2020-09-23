//
//  TableCellView.h
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCellView : UITableViewCell{
    NSString *Content;
}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *date;

@end

NS_ASSUME_NONNULL_END
