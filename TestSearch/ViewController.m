//
//  ViewController.m
//  TestSearch
//
//  Created by 苹果 on 15/9/15.
//  Copyright (c) 2015年 YDS. All rights reserved.
//

#import "ViewController.h"
#import "SearchTableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray * array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * url = @"http://express.tao2.me/app4/getAddressNew";
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        if (data) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.array = [dic[@"data"] allKeys];
            NSLog(@"dic = %@", self.array);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"search" sender:self];
            });
        }
    }else{
        NSLog(@"error = %@", error);
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"search"]) {
        SearchTableViewController * searchVC = [segue destinationViewController];
        searchVC.dataArray = self.array;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
