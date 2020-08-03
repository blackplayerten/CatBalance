//
//  SectionHeader.m
//  some
//
//  Created by a.kurganova on 16.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PureLayout/PureLayout.h>
#import "Collection.h"
#import "SectionHeader.h"

@interface SectionHeader ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation SectionHeader
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _header = [UILabel new];
        _header.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        _header.textAlignment = NSTextAlignmentLeft;
        _header.textColor = UIColor.darkGrayColor;

        [self updateConstraints];
    }
    return self;
}

-(void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self addSubview:self.header];
        [self.header autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:15];
        [self.header autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:self];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}
@end
