//
//  SaveViewController.m
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <Foundation/Foundation.h>
#import "SaveViewController.h"
#import "TableCell.h"
#import "TableCellView.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
//View
static NSMutableArray *itemList;
@interface SaveViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self ReadDataPrivate];
    [self.tableView delegate];
    [self.tableView dataSource];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)ReadDataPrivate {
    itemList = [[NSMutableArray alloc]init];
    NSString *filepathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:filepathBundle];
    NSArray *newsDowload = [root objectForKey:@"NewsDownload"];
    for (NSDictionary *dic in newsDowload) {
        [itemList addObject:[dic copy]];
    }
    NSLog(@"%@", itemList);
}

//read data from Data.plist
+ (void)ReadData {
    itemList = [[NSMutableArray alloc]init];
    NSString *filepathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:filepathBundle];
    NSArray *newsDowload = [root objectForKey:@"NewsDownload"];
    for (NSDictionary *dic in newsDowload) {
        [itemList addObject:[dic copy]];
    }
}

+ (void)AddNewsToDownloadPlist:(NSDictionary *)dic {
    [itemList addObject:dic];
    NSLog(@"%@", itemList);
    [self SaveData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [itemList removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

+ (void)SaveData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *filePath = [basePath stringByAppendingPathComponent:@"Data.plist"];
    [itemList writeToFile:filePath atomically:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [[itemList objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *des = [[itemList objectAtIndex:indexPath.row] objectForKey:@"description"];
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"\""];
    NSString *linkImage = [ArrayDescription objectAtIndex:3];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:linkImage]];
    cell.image.image = [UIImage imageWithData:imageData];
    cell.date.text = [[itemList objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    [itemList writeToFile:path atomically:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *storyboardIdentifier = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle:[NSBundle mainBundle]];
    DetailViewController *UIVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetail"];
    UIVC.curren = [itemList objectAtIndex:indexPath.row];
    NSString *des =  [[itemList objectAtIndex:indexPath.row] objectForKey:@"description"];
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"</br>"];
    NSString *str = [ArrayDescription objectAtIndex:1];
    UIVC.sortContent = str;
    
    ArrayDescription = [des componentsSeparatedByString:@"\""];
    str = [ArrayDescription objectAtIndex:1];
    UIVC.UrlOfNew = str;

    ArrayDescription = [des componentsSeparatedByString:@"\""];
    str = [ArrayDescription objectAtIndex:3];
    UIVC.UrlImage = str;
    [self.navigationController pushViewController:UIVC animated:true];
}

@end
