//
//  MGRoundedGradientView.h
//  MGGlossyButton
//
//  Created by Matt Glover on 08/01/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGRoundedGradientView : UIView

@property (nonatomic, retain) UIColor *faceColor;
@property (nonatomic, retain) UIColor *borderColor;

+ (id)roundedGradientView;
+ (id)roundedGradientViewWithFaceColor:(UIColor *)faceColor borderColor:(UIColor *)borderColor;

- (id)initWithFrame:(CGRect)frame faceColor:(UIColor *)faceColor borderColor:(UIColor *)borderColor;

@end
