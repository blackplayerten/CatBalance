//
//  AppDelegate.h
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @brief интерфейс для стартовой точки входа
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>
/**
 * @return текущее состояние приложения для печати
 */
- (NSString *)getAppState;
/**
 * @param currentstate текущее состояние приложения
 */
- (void)getCurrentAppState:(UIApplicationState *)currentstate;
@end

