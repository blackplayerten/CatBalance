//
//  ViewController.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "CollectionView.h"
#import "Cell.h"

@interface MainView ()

@end

@implementation MainView
UINavigationBar* nav;
CollectionView* coll;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    coll = [[CollectionView alloc]init];

    [self setNavigation];
    [coll inittCollection];
    [self settCol];
}

- (void)setNavigation {
    UIWindow* window = UIApplication.sharedApplication.windows.firstObject;
    const int top_padding = window.safeAreaInsets.top;

    nav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    nav.prefersLargeTitles = YES;
    [self.view addSubview:nav];
    
    UIView* newView = [[UIView alloc] init];
    [nav addSubview:newView];
    newView.translatesAutoresizingMaskIntoConstraints = NO;

    [newView.centerXAnchor constraintEqualToAnchor:nav.centerXAnchor].active = true;
    [newView.topAnchor constraintEqualToAnchor:nav.topAnchor constant: top_padding].active = true;
    [newView.bottomAnchor constraintEqualToAnchor:nav.bottomAnchor constant: -10].active = true;
    [newView.widthAnchor constraintEqualToConstant:200].active = YES;
    
    newView.layer.borderWidth = 0.2;
    newView.layer.borderColor = UIColor.lightGrayColor.CGColor;
}

-(void)settCol {
    coll.col.translatesAutoresizingMaskIntoConstraints = false;
    [coll.col registerClass:[Cell self] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:coll.col];
    [coll.col.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor].active = YES;
    [coll.col.topAnchor constraintEqualToAnchor:nav.bottomAnchor].active = YES;
    [coll.col.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    coll.col.layer.backgroundColor = UIColor.whiteColor.CGColor;
}
@end
