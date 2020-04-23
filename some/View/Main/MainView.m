//
//  ViewController.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PureLayout/PureLayout.h>
#import "MainView.h"
#import "Collection.h"
#import "Cell.h"
#import "SectionHeader.h"
#import "Category.h"

@interface MainView ()
@property (strong, nonatomic) UINavigationBar *customNavigationBar;
@property (strong, nonatomic) UILabel* spendingsLabel;
@property (strong, nonatomic) UILabel* accumulationLabel;
@property (strong, nonatomic) UICollectionView *collection;
@property (strong, nonatomic) NSMutableArray<Category*> *allSpendings;
@property (strong, nonatomic) NSMutableArray<Category*> *allAccumulation;
@end

@implementation MainView
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    self.allSpendings = [NSMutableArray<Category*> new];
    self.allAccumulation = [NSMutableArray<Category*> new];

    [self setNavigation];
    [self spendings];

    [self check];
    self.collection = [[Collection alloc] inittCollection:self.view];
    [self.collection setDataSource: self];
    [self.collection setDelegate: self];
}

-(void)check {
    if ([self.allSpendings count] == 0 && [self.allAccumulation count] == 0) {
        self.collection.hidden = YES;
    } else {
        [self setCollection];
    }
}

#pragma mark - navigation
- (void)setNavigation {
    self.customNavigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0,
                                                                                self.view.bounds.size.width, 100)];
    [self.view addSubview:self.customNavigationBar];
    
    UIView* moneyNavigationView = [UIView new];
    [self.customNavigationBar addSubview:moneyNavigationView];
    moneyNavigationView.translatesAutoresizingMaskIntoConstraints = NO;

    [moneyNavigationView.centerXAnchor constraintEqualToAnchor:self.customNavigationBar.centerXAnchor].active = true;
    [moneyNavigationView.topAnchor constraintEqualToAnchor:self.customNavigationBar.topAnchor
                                                  constant: 44].active = YES;
    [moneyNavigationView.bottomAnchor constraintEqualToAnchor:self.customNavigationBar.bottomAnchor
                                                     constant: -10].active = YES;
    [moneyNavigationView.widthAnchor constraintEqualToConstant:200].active = YES;

    self.spendingsLabel = [UILabel new];
    self.accumulationLabel = [UILabel new];
    NSArray* labels = [NSArray arrayWithObjects: self.spendingsLabel, self.accumulationLabel, nil];
    for (UILabel* label in labels) {
        [moneyNavigationView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [label.topAnchor constraintEqualToAnchor:moneyNavigationView.topAnchor constant:5].active = YES;
        [label.heightAnchor constraintEqualToConstant:20].active = YES;
        [label.widthAnchor constraintEqualToConstant:100].active = YES;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.orangeColor;
    }
    [self.spendingsLabel.leftAnchor constraintEqualToAnchor:moneyNavigationView.leftAnchor].active = YES;
    [self.accumulationLabel.rightAnchor constraintEqualToAnchor:moneyNavigationView.rightAnchor].active = YES;

    UILabel* spendingsTitle = [UILabel new];
    UILabel* accumulationTitle = [UILabel new];
    NSArray* titles = [NSArray arrayWithObjects: spendingsTitle, accumulationTitle, nil];

    for (UILabel* title in titles) {
        [moneyNavigationView addSubview:title];
        title.translatesAutoresizingMaskIntoConstraints = NO;
        [title.bottomAnchor constraintEqualToAnchor:moneyNavigationView.bottomAnchor].active = YES;
        [title.heightAnchor constraintEqualToConstant:20].active = YES;
        [title.widthAnchor constraintEqualToConstant:100].active = YES;
        
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = UIColor.darkGrayColor;
    }
    [spendingsTitle.leftAnchor constraintEqualToAnchor:moneyNavigationView.leftAnchor].active = YES;
    [accumulationTitle.rightAnchor constraintEqualToAnchor:moneyNavigationView.rightAnchor].active = YES;
    
    spendingsTitle.text = @"Spendings";
    accumulationTitle.text = @"Accumulation";
    
#pragma mark button add category
    UIButton *addCategoryButton = [UIButton new];
    [self.customNavigationBar addSubview:addCategoryButton];
    addCategoryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [addCategoryButton.centerYAnchor constraintEqualToAnchor:self.customNavigationBar.centerYAnchor
                                                    constant:20].active = YES;
    [addCategoryButton.rightAnchor constraintEqualToAnchor:self.customNavigationBar.rightAnchor
                                                  constant:-20].active = YES;
    [addCategoryButton.widthAnchor constraintEqualToConstant:40].active = YES;
    [addCategoryButton.heightAnchor constraintEqualToConstant:40].active = YES;
    
    [addCategoryButton setBackgroundImage:[UIImage imageNamed:@"money_add"] forState:UIControlStateNormal];
    [addCategoryButton addTarget:self action:@selector(adding_category) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateBalanceInfo: (NSInteger)spendings accumulation:(NSInteger)accumulation {
    self.spendingsLabel.text = [NSString stringWithFormat:@"%ld ₽", (long)spendings];
    self.accumulationLabel.text = [NSString stringWithFormat:@"%ld ₽", (long)accumulation];
}

-(void)spendings {
    [self updateBalanceInfo:0 accumulation:0];
}

#pragma mark: - adding category
-(void)adding_category {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Category"
                                                                       message:@"\n\n\n\n\n\n"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *categoriesView = [self choosingView: alert.view];
    
    UISwitch *switch_spendings = [UISwitch new];
    [self choosingSection:categoriesView title:@"Spendings" _switch:switch_spendings _top:0];
    
    UISwitch *switch_accumulation = [UISwitch new];
    [self choosingSection:categoriesView title:@"Accumulation" _switch:switch_accumulation _top:50];
    
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) { }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input category name here";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input balance on category here";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction* addButton = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
        UITextField *textFieldName = alert.textFields[0];
        UITextField *textFieldBalance = alert.textFields[1];
        NSInteger balance = [textFieldBalance.text integerValue];

        Category* addingCategory = [Category new];
        addingCategory.name = textFieldName.text;
        addingCategory.balance = balance;

        if (switch_spendings.on) {
            [self.allSpendings addObject:addingCategory];
        }
        
        if (switch_accumulation.on) {
            [self.allAccumulation addObject:addingCategory];
        }
        
        [self check];
        [self.collection reloadData];
    }];
    
    [alert addAction:addButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(UIView*)choosingView:(UIView*)view {
    UIView *view_choosing = [[UIView alloc] initForAutoLayout];
    [view addSubview:view_choosing];
    view_choosing.backgroundColor = UIColor.clearColor;
    view_choosing.layer.cornerRadius = 10;
    [view_choosing autoSetDimensionsToSize:CGSizeMake(235, 90)];
    [view_choosing autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:60];
    [view_choosing autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view withOffset:-125];
    [view_choosing autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:20];
    [view_choosing autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:-20];
    return view_choosing;
}

-(UIView*)choosingSection:(UIView*)view title:(NSString*)title _switch:(UISwitch*)switch_ _top:(NSInteger)top {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(40, top, 160, 30)];
    [view addSubview:sectionView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];

    [sectionView addSubview:label];
    [label setText:title];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [sectionView addSubview:switch_];
    [switch_ autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:label];
    [switch_ autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:label withOffset:15];
    
    return sectionView;
}

#pragma mark - collection
-(void)setCollection {
    [self.collection registerClass:[Cell self] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerClass:[SectionHeader self]
        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
               withReuseIdentifier:@"header"];
    [self.view addSubview: self.collection];
    self.collection.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collection.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.collection.topAnchor constraintEqualToAnchor:self.customNavigationBar.bottomAnchor].active = YES;
    [self.collection.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    self.collection.backgroundColor = UIColor.whiteColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return [self.allSpendings count];
        break;
    case 1:
        return [self.allAccumulation count];
        break;
    default:
        return 1;
        break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.bounds.size.width, 30);
}

#pragma mark - collection delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [Cell new];
    } else {
        switch (indexPath.section) {
        case 0:
            [cell fillCell: [self.allSpendings objectAtIndex:indexPath.item]];
            break;
        case 1:
            [cell fillCell: [self.allAccumulation objectAtIndex:indexPath.item]];
            break;
        default:
            [cell fillCell: [[Category alloc]initWithName:@"Default" balance:0]];
            break;
        }
    }

    NSInteger new_blanace_spendings = 0;
    NSInteger new_blanace_accumulation = 0;
    
    for (Category* category in self.allSpendings) {
        new_blanace_spendings += category.balance;
    }
    for (Category* category in self.allAccumulation) {
        new_blanace_accumulation += category.balance;
    }
    [self updateBalanceInfo:new_blanace_spendings accumulation:new_blanace_accumulation];
    
    return cell;
}

#pragma mark: - selected cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: go to detail view controller
}
@end
