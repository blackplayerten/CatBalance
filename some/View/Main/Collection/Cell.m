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
    
    self.name = [UILabel new];
    self.imageView = [UIImageView new];
    self.balance = [UILabel new];
    
    [self addSubview:self.name];
    self.name.translatesAutoresizingMaskIntoConstraints = false;
    [self.name.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.name.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self.name.heightAnchor constraintLessThanOrEqualToConstant:20].active = YES;
    self.name.font = [UIFont systemFontOfSize:12];
    self.name.adjustsFontSizeToFitWidth = YES;
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.textColor = UIColor.darkGrayColor;
    self.name.numberOfLines = 0;
    
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    [self addSubview:self.balance];
    self.balance.translatesAutoresizingMaskIntoConstraints = false;
    [self.balance.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.balance.centerYAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:15].active = YES;
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
