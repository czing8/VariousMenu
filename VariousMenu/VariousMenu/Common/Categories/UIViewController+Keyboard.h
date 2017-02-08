//
//  UIViewController+Keyboard.h
//  ProjectControls
//
//  Created by Vols on 2015/11/24.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Protocol
@protocol VCKeyboardDelegate <NSObject>

@optional

/**
 Notifies the view controller that the keyboard will show or hide with specified parameters. This method is called before keyboard animation.
 
 @param height The height of keyboard.
 @param animationDuration The duration of keyboard animation.
 @param animationCurve The animation curve.
 */
- (void)keyboardWillShowOrHideWithHeight:(CGFloat)height
                       animationDuration:(NSTimeInterval)animationDuration
                          animationCurve:(UIViewAnimationCurve)animationCurve;

/**
 The keyboard animation. This method is called inside UIView animation block with the same animation parameters as keyboard animation.
 
 @param height The height of keyboard.
 @param animationDuration The duration of keyboard animation.
 @param animationCurve The animation curve.
 */
- (void)keyboardShowOrHideAnimationWithHeight:(CGFloat)height
                               animationDuration:(NSTimeInterval)animationDuration
                                  animationCurve:(UIViewAnimationCurve)animationCurve;

/**
 Notifies the view controller that the keyboard animation finished. This method is called after keyboard animation.
 
 @param height The height of keyboard.
 */
- (void)keyboardShowOrHideAnimationDidFinishedWithHeight:(CGFloat)height;

@end




@interface UIViewController (Keyboard)

/**
 YES if keyboard height is > 0.
 */
@property (nonatomic, readonly) BOOL isKeyboardPresented;

/**
 The height of keyboard.
 @note Extracted from `UIKeyboardFrameEndUserInfoKey` on show or sets to 0 on hide.
 */
@property (nonatomic, readonly) CGFloat keyboardHeight;

///----------------------------------------------------------------------------
/// @name Notification Handling
///----------------------------------------------------------------------------

/**
 Starts observing for `UIKeyboardWillShowNotification` and `UIKeyboardWillHideNotification` notifications.
 
 @discussion It is recommended to call this method in `-viewWillAppear:`.
 */
- (void)startObservingKeyboardNotifications;

/**
 Stops observing for `UIKeyboardWillShowNotification` and `UIKeyboardWillHideNotification` notifications.
 
 @discussion It is recommended to call this method in `-viewWillDisappear:`.
 */
- (void)stopObservingKeyboardNotifications;


@end
