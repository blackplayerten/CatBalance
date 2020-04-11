//
//  ViewController.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "Collection.h"
#import "Cell.h"

#define defaultNumber 100;

@interface MainView ()
@property (strong, nonatomic) UINavigationBar* nav;
@property (strong, nonatomic) Collection* coll;
@property (strong, nonatomic) UICollectionView* collection;
@end

@implementation MainView
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setNavigation];
    
    self.collection = [[Collection alloc] inittCollection:self.view];
    [self.collection setDataSource: self];
    [self.collection setDelegate: self];
    [self setCollection];
}

- (void)setNavigation {
    self.nav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    self.nav.prefersLargeTitles = YES;
    self.nav.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.nav];
    
    UIView* newView = [UIView new];
    [self.nav addSubview:newView];
    newView.translatesAutoresizingMaskIntoConstraints = NO;

    [newView.centerXAnchor constraintEqualToAnchor:self.nav.centerXAnchor].active = true;
    [newView.topAnchor constraintEqualToAnchor:self.nav.topAnchor constant: 44].active = true;
    [newView.bottomAnchor constraintEqualToAnchor:self.nav.bottomAnchor constant: -10].active = true;
    [newView.widthAnchor constraintEqualToConstant:200].active = YES;
    
    newView.layer.borderWidth = 0.5;
    newView.layer.borderColor = UIColor.darkGrayColor.CGColor;
}

#pragma mark - collection
-(void)setCollection {
    [self.view addSubview: self.collection];
    self.collection.translatesAutoresizingMaskIntoConstraints = false;
    [self.collection registerClass:[Cell self] forCellWithReuseIdentifier:@"cell"];
    [self.collection.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.collection.topAnchor constraintEqualToAnchor:self.nav.bottomAnchor].active = YES;
    [self.collection.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    self.collection.backgroundColor = UIColor.whiteColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return defaultNumber;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - collection delegate
- (Cell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [Cell new];
    } else {
        cell.layer.borderColor = UIColor.darkGrayColor.CGColor;
        cell.layer.borderWidth = 0.3;
    }

    return cell;
}
@end
