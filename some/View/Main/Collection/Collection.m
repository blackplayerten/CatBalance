//
//  Collection.m
//  some
//
//  Created by a.kurganova on 11.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Collection.h"

@interface Collection ()
@property(strong, nonatomic) UICollectionView *collection;
@end

@implementation Collection
- (UICollectionView*)inittCollection: (UIView *)view {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    float cellSide = view.bounds.size.width / 4 - 2;
    CGSize sizecell = CGSizeMake(cellSide, cellSide*1.2);
    layout.itemSize = sizecell;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 15;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return self.collection = [[UICollectionView alloc]initWithFrame:view.frame collectionViewLayout:layout];
}
@end
