//
//  SectionHeader.m
//  some
//
//  Created by a.kurganova on 16.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Collection.h"
#import "SectionHeader.h"

@interface SectionHeader ()
@end

@implementation SectionHeader
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.header = [UILabel new];

        [self addSubview:self.header];
        self.header.translatesAutoresizingMaskIntoConstraints = false;
        [self.header.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15].active = YES;
        [self.header.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        
        self.header.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        self.header.textAlignment = NSTextAlignmentLeft;
        self.header.textColor = UIColor.darkGrayColor;
    }
    return self;
}
@end
