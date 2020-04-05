//
//  Header.h
//  some
//
//  Created by a.kurganova on 05.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionView : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate> {
}
    @property UICollectionView* col;
    - (UICollectionView *)inittCollection;
@end
