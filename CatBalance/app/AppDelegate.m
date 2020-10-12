//
//  AppDelegate.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"

/**
 * @mainpage Приложение для учета контроля расходов
 * // Состоит из:
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

/**
 * @brief интерфейс для локальных полей класса
 */
@interface AppDelegate ()
@property (null_unspecified, nonatomic) UIApplicationState *prevState;
@end

/**
 * @param window
 * // Нужен для создания окна приложения
 */
@implementation AppDelegate
UIWindow *window;

/**
* @param application объект централизированной контрольной точки приложения
 * @param didFinishLaunchingWithOptions загрузка приложения завершена
*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainView *main = [MainView alloc];
    window.rootViewController = main;
    [window makeKeyAndVisible];
    return YES;
}

/**
 * @param applicationWillResignActive приложение собирается стать активным
*/
-(void)applicationWillResignActive:(UIApplication *)application {
    [self getCurrentAppState:(UIApplicationState *) UIApplication.sharedApplication.applicationState
                      method:[NSString stringWithUTF8String:__FUNCTION__]];
}

/**
 * @param applicationDidEnterBackground приложение в фоновом режиме
*/
-(void)applicationDidEnterBackground:(UIApplication *)application {
    [self getCurrentAppState:(UIApplicationState *) UIApplication.sharedApplication.applicationState
                      method: [NSString stringWithUTF8String:__FUNCTION__]];
}

/**
 * @param didFinishLaunchingWithOptions приложение собирается войти в фоновый режим
*/
-(void)applicationWillEnterForeground:(UIApplication *)application {
    [self getCurrentAppState:(UIApplicationState *) UIApplication.sharedApplication.applicationState
                      method: [NSString stringWithUTF8String:__FUNCTION__]];
}

/**
 * @param applicationDidBecomeActive приложение стало активным
*/
-(void)applicationDidBecomeActive:(UIApplication *)application {
    [self getCurrentAppState:(UIApplicationState *) UIApplication.sharedApplication.applicationState
                      method: [NSString stringWithUTF8String:__FUNCTION__]];
}

/**
 * @param applicationWillTerminate приложение сейчас будет завершено
*/
-(void)applicationWillTerminate:(UIApplication *)application {
    [self getCurrentAppState:(UIApplicationState *) UIApplication.sharedApplication.applicationState
                      method: [NSString stringWithUTF8String:__FUNCTION__]];
}

/**
 * @param currentState текущее состояние приложения
 * @param method какая функция инициировала вызов этой функции
*/
-(void)getCurrentAppState: (UIApplicationState *)currentState method:(NSString *)method {
    NSString *previousStateString = [self getAppStateString: self.prevState];
    NSString *currentStateString = [self getAppStateString: currentState];

    if (previousStateString != currentStateString) {
        NSLog(@"called method: %@. application moved from: %@ to %@\n", method, previousStateString, currentStateString);
    } else {
        NSLog(@"called method: %@. application state: %@\n", method, currentStateString);
    }
    self.prevState = currentState;
}
/**
 * @param currentState текущее состояние приложения
 * @return состояние приложения в виде строки
 * для удобного вывода
 */
-(NSString *)getAppStateString: (UIApplicationState *)currentState {
    if (currentState == nil) {
        return @"not running";
    }
    switch (*currentState) {
    case UIApplicationStateInactive:
        return @"inactive";
    case UIApplicationStateBackground:
        return @"background";
    case UIApplicationStateActive:
        return @"active";
    default:
        return @"unknown state";
    }
}
@end
