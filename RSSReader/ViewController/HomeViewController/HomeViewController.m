//
//  HomeViewController.m
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "TableCellView.h"
#import "DetailViewController.h"
#import "SaveViewController.h"
@interface HomeViewController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;//News
    NSMutableDictionary *item;
    NSMutableString *title;//Title of new
    NSMutableString *link;
    NSMutableString *pubDate;
    NSMutableString *description;//content of description Tag in RSS
    NSString *element;
}
@property (strong, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UIView *TableUIView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

static NSMutableArray *NewsDownload;
static NSMutableDictionary *DataTransferCellTemp;
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Read DS from Data.plist
    [SaveViewController ReadData];
    //Custom Button In Slide Menu
    [self.TableUIView setHidden:YES];
    //Set Heigh for Row of Button
    //Create RSS
    feeds = [[NSMutableArray alloc] init];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
}

// Handle for Keyboard
- (void)didTapAnywhere:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

//Start Read RSS
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    element = elementName;
    if ([element isEqualToString:@"item"]) {
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        pubDate   = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        
    }
    
}
//Found String Item IN RSS String
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    else if([element isEqualToString:@"pubDate"])
    {
        [pubDate appendString:string];
    }
    else if([element isEqualToString:@"description"]){
        [description appendString:string];
        
        
    }
    
    
}
//End REad RSS Link Then Add NSDictionary to NSArray
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:description forKey:@"description"];
        [feeds addObject:[item copy]];
    }
    
}

// Crate Mark News Want to Download
- (id)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Mark as Unread" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSDictionary *dic = [self->feeds objectAtIndex:indexPath.row];
        [SaveViewController AddNewsToDownloadPlist:dic];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Download Successful"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        //[alert release];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[editAction];
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.table reloadData];
    
}
//Number Of Section Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//Number OF ROw
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString * des=  [[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    //Spitting string to get Link Image
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"\""];
    NSString *linkImage =[ArrayDescription objectAtIndex:3];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:linkImage]];
    cell.image.image = [UIImage imageWithData: imageData];
    cell.date.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    return cell;
    
    
}
//Function: Click on Row in Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * storyboardIdentifier = @"Main";// for example "Main.storyboard" then you have to take only "Main"
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: [NSBundle mainBundle]];
    DetailViewController* UIVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetail"];
    UIVC.curren = [feeds objectAtIndex:indexPath.row];
    NSString * des=  [[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"</br>"];
    NSString *str =[ArrayDescription objectAtIndex:1];
    UIVC.sortContent = str;
    
    ArrayDescription = [des componentsSeparatedByString:@"\""];
    str =[ArrayDescription objectAtIndex:1];
    UIVC.UrlOfNew = str;
    
    ArrayDescription = [des componentsSeparatedByString:@"\""];
    str =[ArrayDescription objectAtIndex:3];
    UIVC.UrlImage=str;
    [self.navigationController pushViewController:UIVC animated:true];
}


- (IBAction)search:(id)sender {
    if (_urlField != nil) {
        NSURL *url = [NSURL URLWithString: _urlField.text];
        self.urlField.text = @"";
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [parser setDelegate: (id)self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
        [_table reloadData];
    }
}

@end
