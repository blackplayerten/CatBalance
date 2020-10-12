//
//  Category.m
//  some
//
//  Created by a.kurganova on 16.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Category.h"

/**
 * @brief класс для работы с категорией расходов
 */
@interface Category ()

@end

@implementation Category
/**
 * @param name наименование категории
 * @param balance вводимый баланс в данной категории
 * @return уникальный объект категории
 */
-(id)initWithName:(NSString *)name balance:(NSInteger)balance {
    self = [super init];
    if (self) {
        self.name = name;
        self.balance = balance;
    }
    return self;
}
@end
