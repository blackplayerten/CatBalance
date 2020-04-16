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
#import "SectionHeader.h"

#define defaultNumber 5;
#define numberSections 2;

@interface MainView ()
@property (strong, nonatomic) UINavigationBar* customNavigationBar;
@property int spendings;
@property int accumulation;
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

#pragma mark - navigation
- (void)setNavigation {
    self.customNavigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0,
                                                                                self.view.bounds.size.width, 100)];
    self.customNavigationBar.prefersLargeTitles = YES;
    [self.view addSubview:self.customNavigationBar];
    
    UIView* moneyNavigationView = [UIView new];
    [self.customNavigationBar addSubview:moneyNavigationView];
    moneyNavigationView.translatesAutoresizingMaskIntoConstraints = NO;

    [moneyNavigationView.centerXAnchor constraintEqualToAnchor:self.customNavigationBar.centerXAnchor].active = true;
    [moneyNavigationView.topAnchor constraintEqualToAnchor:self.customNavigationBar.topAnchor
                                                  constant: 44].active = true;
    [moneyNavigationView.bottomAnchor constraintEqualToAnchor:self.customNavigationBar.bottomAnchor
                                                     constant: -10].active = true;
    [moneyNavigationView.widthAnchor constraintEqualToConstant:200].active = YES;
    
    UILabel* spendingsLabel = [UILabel new];
    UILabel* accumulationLabel = [UILabel new];
    NSArray* labels = [NSArray arrayWithObjects: spendingsLabel, accumulationLabel, nil];
    for (int i = 0; i < [labels count]; i++) {
        UILabel* label = [UILabel new];
        [moneyNavigationView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = false;
        [label.topAnchor constraintEqualToAnchor:moneyNavigationView.topAnchor constant:5].active = YES;
        [label.heightAnchor constraintEqualToConstant:20].active = YES;
        [label.widthAnchor constraintEqualToConstant:100].active = YES;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.orangeColor;
        if (i == 0) {
            spendingsLabel = label;
            [spendingsLabel.leftAnchor constraintEqualToAnchor:moneyNavigationView.leftAnchor].active = YES;
            NSString* balance_string = [NSString stringWithFormat:@"%d", self.spendings];
            spendingsLabel.text = [balance_string stringByAppendingString:@" ₽"];
        } else {
            accumulationLabel = label;
            [accumulationLabel.rightAnchor constraintEqualToAnchor:moneyNavigationView.rightAnchor].active = YES;
            NSString* consumption_string = [NSString stringWithFormat:@"%d", self.accumulation];
            accumulationLabel.text = [consumption_string stringByAppendingString:@" ₽"];
        }
    }

    UILabel* spendingsTitle = [UILabel new];
    UILabel* accumulationTitle = [UILabel new];
    NSArray* titles = [NSArray arrayWithObjects: spendingsTitle, accumulationTitle, nil];

    for (int i = 0; i < [titles count]; i++) {
        UILabel* title = [UILabel new];
        [moneyNavigationView addSubview:title];
        
        title.translatesAutoresizingMaskIntoConstraints = false;
        [title.bottomAnchor constraintEqualToAnchor:moneyNavigationView.bottomAnchor].active = YES;
        [title.heightAnchor constraintEqualToConstant:20].active = YES;
        [title.widthAnchor constraintEqualToConstant:100].active = YES;
        
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = UIColor.darkGrayColor;
        
        if (i == 0) {
            spendingsTitle = title;
            [spendingsTitle.leftAnchor constraintEqualToAnchor:moneyNavigationView.leftAnchor].active = YES;
            spendingsTitle.text = @"Spendings";
        } else {
            accumulationTitle = title;
            [accumulationTitle.rightAnchor constraintEqualToAnchor:moneyNavigationView.rightAnchor].active = YES;
            accumulationTitle.text = @"Accumulation";
        }
    }
}

#pragma mark - collection
-(void)setCollection {
    [self.collection registerClass:[Cell self] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerClass:[SectionHeader self]
        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
               withReuseIdentifier:@"header"];

    [self.view addSubview: self.collection];
    self.collection.translatesAutoresizingMaskIntoConstraints = false;
    [self.collection.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.collection.topAnchor constraintEqualToAnchor:self.customNavigationBar.bottomAnchor].active = YES;
    [self.collection.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    self.collection.backgroundColor = UIColor.whiteColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return defaultNumber;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return numberSections;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 0, 25, 0);
}

#pragma mark: section header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SectionHeader *reusableview = [collectionView
                                   dequeueReusableSupplementaryViewOfKind:kind
                                   withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if (reusableview == nil) {
        reusableview = [SectionHeader new];
    } else {
        switch (indexPath.section) {
        case 0:
            reusableview.header.text=@"Spendings";
            break;
        case 1:
            reusableview.header.text=@"Accumulation";
            break;
        default:
            reusableview.header.text=@"Unknown section";
            break;
        }
    }

    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(self.view.bounds.size.width, 30);
    return headerSize;
}

#pragma mark - collection delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [Cell new];
    } else {
        cell.name.text = @"Category Eda";
        cell.imageView.image = [[UIImage imageNamed:[[Cell new] getRandomCat]]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString* balance_string = [NSString stringWithFormat:@"%d", self.spendings];
        cell.balance.text = [balance_string stringByAppendingString:@" ₽"];
    }

    return cell;
}
@end
