//
//  Cell.h
//  some
//
//  Created by a.kurganova on 05.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface Cell : UICollectionViewCell
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *balance;

-(void) fillCell: (Category *)modell;
-(NSString*) getRandomCat;
@end
