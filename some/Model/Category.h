//
//  Category.h
//  some
//
//  Created by a.kurganova on 16.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Category : NSObject 
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) UIImage* image;
@property NSInteger balance;
-(id)initWithName:(NSString *)name balance:(NSInteger)balance;
@end
