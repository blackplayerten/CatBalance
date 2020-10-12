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
#import "DetailBalance.h"

/**
 * @file MainView.m
 * @date 03/04/2020
 * @author Кургавнова Александра ИУ5-11М
 * @brief главный экран приложения
 */

@interface MainView ()
/**
 * @param customNavigationBar навигационная панель с отображением расходов
 * @param spendingsLabel подпись отображения накоплений
 * @param accumulationLabel подпись отображения расходов
 * @param collection коллекционное представление с категориями
 * @param allSpendings данные о накоплениях
 * @param allAccumulation данные о расходах
 */

@property (strong, nonatomic) UINavigationBar *customNavigationBar;
@property (strong, nonatomic) UILabel *spendingsLabel;
@property (strong, nonatomic) UILabel *accumulationLabel;
@property (strong, nonatomic) UICollectionView *collection;
// like MVC pattern
@property (strong, nonatomic) NSMutableArray<Category*> *allSpendings;
@property (strong, nonatomic) NSMutableArray<Category*> *allAccumulation;
@end

@implementation MainView
/**
 * @brief метод когда экран приложения загружен в память
 * установка значений для расходов: накоплений и трат
 * установка коллекционного представления категорий
 */
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

/**
 * @brief метод проверки, есть ли какие-то категории
 */
-(void)check {
    if ([self.allSpendings count] == 0 && [self.allAccumulation count] == 0) {
        self.collection.hidden = YES;
    } else {
        [self setCollection];
    }
}

/**
 * @brief метод установки navigation с балансом, обновление баланса
 */
#pragma mark - navigation
- (void)setNavigation {
    self.customNavigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0,
                                                                                self.view.bounds.size.width, 100)];
    [self.view addSubview:self.customNavigationBar];
    
    UIView *moneyNavigationView = [UIView newAutoLayoutView];
    [self.customNavigationBar addSubview:moneyNavigationView];

    [moneyNavigationView autoSetDimensionsToSize:CGSizeMake(200, 46)];
    [moneyNavigationView autoConstrainAttribute:ALAttributeVertical
                                    toAttribute:ALAttributeVertical ofView:self.customNavigationBar];
    [moneyNavigationView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.customNavigationBar withOffset:44];

    self.spendingsLabel = [UILabel newAutoLayoutView];
    self.accumulationLabel = [UILabel newAutoLayoutView];
    NSArray *labels = [NSArray arrayWithObjects: self.spendingsLabel, self.accumulationLabel, nil];
    for (UILabel *label in labels) {
        [moneyNavigationView addSubview:label];
        [label autoSetDimensionsToSize:CGSizeMake(100, 20)];
        [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:moneyNavigationView withOffset:5];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.orangeColor;
    }
    [self.spendingsLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:moneyNavigationView];
    [self.accumulationLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:moneyNavigationView];

    UILabel *spendingsTitle = [UILabel newAutoLayoutView];
    UILabel *accumulationTitle = [UILabel newAutoLayoutView];
    NSArray *titles = [NSArray arrayWithObjects: spendingsTitle, accumulationTitle, nil];
    for (UILabel *title in titles) {
        [moneyNavigationView addSubview:title];
        [title autoSetDimensionsToSize:CGSizeMake(100, 20)];
        [title autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:moneyNavigationView];
        
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = UIColor.darkGrayColor;
    }
    [spendingsTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:moneyNavigationView];
    [accumulationTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:moneyNavigationView];
    
    spendingsTitle.text = @"Spendings";
    accumulationTitle.text = @"Accumulation";
    
#pragma mark button add category
    UIButton *addCategoryButton = [UIButton new];
    [self.customNavigationBar addSubview:addCategoryButton];
    [addCategoryButton autoSetDimensionsToSize:CGSizeMake(40, 40)];
    [addCategoryButton autoConstrainAttribute:ALAttributeHorizontal
                                  toAttribute:ALAttributeHorizontal ofView:self.customNavigationBar withOffset:20];
    [addCategoryButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.customNavigationBar withOffset:-20];
    
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

/**
 * @brief метод добавления новой категории
 * текстовое поле для ввода названия категорий
 * выбор определенной категориии расходов
 */
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
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) { }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input category name here";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input balance on category here";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction *addButton = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action) {
        UITextField *textFieldName = alert.textFields[0];
        UITextField *textFieldBalance = alert.textFields[1];
        NSInteger balance = [textFieldBalance.text integerValue];

        if (switch_spendings.on) {
            Category *addingCategory = [Category new];
            addingCategory.name = textFieldName.text;
            addingCategory.balance = balance;
            [self.allSpendings addObject:addingCategory];
        }
        
        if (switch_accumulation.on) {
            Category *addingCategory = [Category new];
            addingCategory.name = textFieldName.text;
            addingCategory.balance = balance;
            [self.allAccumulation addObject:addingCategory];
        }
        
        [self check];
        [self.collection reloadData];
    }];
    
    [alert addAction:addButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 * @brief функция для создания представления для создания категории
 * @param view на какое визуальное представление нужно добавить представление категории
 * @return новое представление с установленной категорией
 */
-(UIView*)choosingView: (UIView *)view {
    UIView *view_choosing = [[UIView alloc] initForAutoLayout];
    [view addSubview:view_choosing];
    [view_choosing autoSetDimensionsToSize:CGSizeMake(235, 90)];
    [view_choosing autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:55];
    [view_choosing autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view withOffset:-125];
    [view_choosing autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:view];
    
    view_choosing.backgroundColor = UIColor.clearColor;
    view_choosing.layer.cornerRadius = 10;

    return view_choosing;
}

/**
 * @brief функция для создания представления для выбора категории расходов
 * @param view на какое визуальное представление нужно добавить представление выбора категории
 * @param title название категории
 * @param switch_ индикатор выбора категории
 * @param top отступ сверху от предыдущего представления
 * @return представление с возможность выбора категории
 */
-(UIView*)choosingSection: (UIView*)view title:(NSString*)title _switch:(UISwitch*)switch_ _top:(NSInteger)top {
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

/**
 * @brief функция установки коллекционного представления с категориями
 */
#pragma mark - collection
-(void)setCollection {
    [self.collection registerClass:[Cell self] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerClass:[SectionHeader self]
        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
               withReuseIdentifier:@"header"];
    [self.view addSubview: self.collection];
    [self.collection autoPinEdgeToSuperviewSafeArea:ALEdgeTop withInset:self.view.safeAreaInsets.top+14];
    [self.collection autoSetDimensionsToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    self.collection.backgroundColor = UIColor.whiteColor;
}
/**
 *
 * @param collectionView коллекционное представление
 * @param section сколько ячеек будет в коллекции
 * @return количество ячеек
 */
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return [self.allSpendings count];
    case 1:
        return [self.allAccumulation count];
    default:
        return 1;
    }
}

/**
 *
 * @param collectionView коллекционное представление
 * @return количесво секций у коллекции
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

/**
 *
 * @param collectionView коллекционное представление
 * @param collectionViewLayout заголовок секции
 * @param section номер секции
 * @return отступы и размеры для заголовка секции
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 0, 25, 0);
}

#pragma mark: section header
/**
 *
 * @param collectionView коллекционное представление
 * @param kind тип заголовка: верхний или нижний
 * @param indexPath индекс ячейки
 * @return переиспользованная ячейка коллекции
 */
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
/**
 *
 * @param collectionView коллекционное представление
 * @param indexPath инлекс ячейки
 * @return сконфигурированная ячейка
 */
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
    
    for (Category *category in self.allSpendings) {
        new_blanace_spendings += category.balance;
    }
    for (Category *category in self.allAccumulation) {
        new_blanace_accumulation += category.balance;
    }
    [self updateBalanceInfo:new_blanace_spendings accumulation:new_blanace_accumulation];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(updateBalanceCategory:)];
    longPress.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailBalance *detail = [DetailBalance new];
    [self presentViewController:detail animated:true completion:nil];
}

#pragma mark: update balance info on category
-(void)updateBalanceCategory: (UILongPressGestureRecognizer*)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Update balance" message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) { }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input new balance";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];

    UIAlertAction *updateBalance = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action) {
        UITextField *textFieldBalance = alert.textFields[0];
        NSInteger balance = [textFieldBalance.text integerValue];

        if([sender.view isKindOfClass:[Cell class]]) {
            Cell *senderView = (Cell*)sender.view;
            NSArray *updatedItems = [NSArray arrayWithObject:[self.collection indexPathForCell:senderView]];

            NSInteger section = (long)[self.collection indexPathForCell:senderView].section;
            NSInteger indexItem = (long)[self.collection indexPathForCell:senderView].item;
            
            switch (section) {
            case 0:
                self.allSpendings[indexItem].balance += balance;
                break;
            case 1:
                self.allAccumulation[indexItem].balance += balance;
                break;
            default:
                break;
            }
            [self.collection reloadItemsAtIndexPaths:updatedItems];
        }
    }];

    [alert addAction:updateBalance];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
