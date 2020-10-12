//
//  main.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

/**
 * @mainpage Приложение для учета контроля расходов
 * Состоит из:
 * @ref AppDelegate Стартовая точка входа приложения
 * @ref MainView главный экран приложения
 * @ref Collection коллекционное представление категорий расходов
 * @file main.m
 * @brief файл исходного кода старта программы
 * @copyright a.kurganova
 * @author Курганова Александра, ИУ5-11М
 * @date 03-04-2020
 * @version 1.0.1
 */

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
