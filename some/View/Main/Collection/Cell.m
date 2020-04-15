//
//  Cell.m
//  some
//
//  Created by a.kurganova on 05.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Cell ()
@end

@implementation Cell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.imageView = [UIImageView new];
    self.balance = [UILabel new];
    
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:-15].active = YES;
    
    [self addSubview:self.balance];
    self.balance.translatesAutoresizingMaskIntoConstraints = false;
    [self.balance.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.balance.centerYAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:25].active = YES;
    self.balance.textAlignment = NSTextAlignmentCenter;
    self.balance.textColor = UIColor.orangeColor;

    return self;
}

-(NSString*) getRandomCat {
    UInt32 numberOfImages = 53;
    uint32_t random = arc4random_uniform(numberOfImages);
    NSString *imageName = [@"cats/cat_" stringByAppendingFormat:@"%u", random];
    return imageName;
}

@end
