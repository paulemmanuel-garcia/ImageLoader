//
//  ViewController.m
//  Example-objc
//
//  Created by Paul-Emmanuel on 12/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

#import "ViewController.h"
#import <ImageLoader/ImageLoader.h>
#import <ImageLoader/ImageLoader-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [RVSImageLoader.loader loadImageFrom:@"https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg" withCompletion:^(UIImage *image, NSError *error) {
        NSLog(@"Image downloaded");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
