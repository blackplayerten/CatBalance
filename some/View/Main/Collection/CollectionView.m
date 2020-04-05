//
//  NSObject+CollectionView.h
//  some
//
//  Created by a.kurganova on 05.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionView.h"
#import "Cell.h"

@interface CollectionView ()

@end

@implementation CollectionView
const int defaultNumber = 100;

- (UICollectionView *)inittCollection {
    float cellSide = self.view.bounds.size.width / 3 - 1;
    CGSize sizecell = CGSizeMake(cellSide, cellSide);
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = sizecell;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.col = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.col setDataSource: self];
    [self.col setDelegate: self];
    
    return self.col;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return defaultNumber;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - collection delegate
- (Cell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[Cell alloc] init];
    } else {
        cell.layer.borderColor = UIColor.lightGrayColor.CGColor;
        cell.layer.borderWidth = 0.2;
    }

    return cell;
}
@end
