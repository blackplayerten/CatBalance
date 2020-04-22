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

@interface Category ()

@end

@implementation Category
-(id)initWithName:(NSString *)name balance:(NSInteger)balance {
    self = [super init];
    if (self) {
        self.name = name;
        self.balance = balance;
    }
    return self;
}
@end

struct Default {
    NSString *name;
    UIImage *image;
    int balance;
};
