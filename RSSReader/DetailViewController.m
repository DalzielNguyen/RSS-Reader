//
//  DetailViewController.m
//  RSSReader
//
//  Created by Le-Sang Nguyen on 9/21/20.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.ImageOfNews.layer setBorderColor: [[UIColor grayColor] CGColor]];
    //    [self.ImageOfNews.layer  setBorderWidth: 2.0];
    //
    self.TitleOfNew.text = [self.curren objectForKey:@"title"];
    //self.UrlOfNew = [self.curren objectForKey:@"link"];
    self.SortContentOfNews.text = self.sortContent;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.UrlImage]];
    self.ImageOfNews.image = [UIImage imageWithData:imageData];
    // Do any additional setup after loading the view.
}

- (IBAction)ShareNew:(UIButton *)sender {
    NSString *textToShare = @"Look at this awesome News!";
    NSURL *myWebsite = [NSURL URLWithString:self.UrlOfNew];
    NSArray *objectsToShare = @[textToShare, myWebsite];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];

    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];

    activityVC.excludedActivityTypes = excludeActivities;

    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)Setting:(UIBarButtonItem *)sender {
}

- (IBAction)ShareNews:(UIBarButtonItem *)sender {
    NSString *textToShare = @"Look at this awesome News!";
    NSURL *myWebsite = [NSURL URLWithString:self.UrlOfNew];
    NSArray *objectsToShare = @[textToShare, myWebsite];

    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];

    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];

    activityVC.excludedActivityTypes = excludeActivities;

    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)SaveNewsOffline:(UIBarButtonItem *)sender {
    [SaveViewController AddNewsToDownloadPlist:self.curren];
}

- (IBAction)VisitToWebsite:(UIButton *)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:self.UrlOfNew];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

@end
