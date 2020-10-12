//
//  Collection.h
//  some
//
//  Created by a.kurganova on 11.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief интерфейс для инициализации коллекции
 * @ref initCollection инициализация коллекции
 */
@interface Collection: UICollectionView
/**
 *
 * @param view на какое представление нужно добавить коллекцию
 * @return коллекционное представление
 */
- (UICollectionView*)inittCollection: (UIView *)view;
@end
