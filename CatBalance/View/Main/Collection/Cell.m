//
//  Cell.m
//  some
//
//  Created by a.kurganova on 05.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PureLayout/PureLayout.h>
#import "Cell.h"
#import "Category.h"

@interface Cell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation Cell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _name = [UILabel newAutoLayoutView];
        _imageView = [UIImageView newAutoLayoutView];
        _balance = [UILabel newAutoLayoutView];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.contentView addSubview:self.name];
        [self.name autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:5];
        [self.name autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:10];
        [self.name autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-10];
        [self.name autoSetDimension:ALDimensionHeight toSize:20];
        
        self.name.font = [UIFont systemFontOfSize:12];
        self.name.adjustsFontSizeToFitWidth = YES;
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.textColor = UIColor.darkGrayColor;
        self.name.numberOfLines = 0;
        
        [self.contentView addSubview:self.imageView];
        [self.imageView autoCenterInSuperview];
        
        [self.contentView addSubview:self.balance];
        [self.balance autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:5];
        [self.balance autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self];
        
        self.balance.textAlignment = NSTextAlignmentCenter;
        self.balance.textColor = UIColor.orangeColor;
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

-(NSString*)getRandomCat {
    UInt32 numberOfImages = 53;
    uint32_t random = arc4random_uniform(numberOfImages);
    NSString *imageName = [@"cats/cat_" stringByAppendingFormat:@"%u", random];
    return imageName;
}

-(void)fillCell: (Category*)model {
    if (![model.name isEqual: @""]) {
        self.name.text = model.name;
    } else {
        self.name.text = @"Default";
    }
    self.imageView.image = [[UIImage imageNamed:[self getRandomCat]]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.balance.text = [NSString stringWithFormat:@"%ld ₽", (long)model.balance];
}
@end
