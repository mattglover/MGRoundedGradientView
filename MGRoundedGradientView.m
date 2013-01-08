//
//  MGRoundedGradientView.m
//  MGGlossyButton
//
//  Created by Matt Glover on 08/01/2013.
//  Copyright (c) 2013 iOS Newcastle. All rights reserved.
//

#import "MGRoundedGradientView.h"

#import <QuartzCore/QuartzCore.h>

#define DEFAULT_WIDTH  300.0f
#define DEFAULT_HEIGHT 300.0f
#define DEFAULT_CORNER_RADIUS 20.0f
#define DEFAULT_BORDER_WIDTH 4.0f

@implementation MGRoundedGradientView
@synthesize faceColor = _faceColor;
@synthesize borderColor = _borderColor;

+ (id)roundedGradientView  {
  return [[[MGRoundedGradientView alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT) faceColor:[UIColor lightGrayColor] borderColor:[UIColor blackColor]] autorelease];
}

+ (id)roundedGradientViewWithFaceColor:(UIColor *)faceColor borderColor:(UIColor *)borderColor {
  return [[[MGRoundedGradientView alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT) faceColor:faceColor borderColor:borderColor] autorelease];
}

- (id)initWithFrame:(CGRect)frame faceColor:(UIColor *)faceColor borderColor:(UIColor *)borderColor {
  self = [super initWithFrame:frame];
  if (self) {
    
    _faceColor = faceColor;
    _borderColor = borderColor;
    
    [self setup];
  }
  
  return self;
}

- (void)setup {
  
  self.backgroundColor = [UIColor clearColor];
  
  CAShapeLayer *shapeLayer = [self shapeWithBounds:self.bounds];
  [shapeLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
  
  CAGradientLayer *gradientLayer = [self gradientLayerWithBounds:shapeLayer.bounds];
  [gradientLayer setMask:[self shapeMask]];
  [shapeLayer addSublayer:gradientLayer];
  
  [self.layer setShadowColor:[UIColor blackColor].CGColor];
  [self.layer setShadowOpacity:0.75f];
  [self.layer setShadowOffset:CGSizeMake(0, 1.0f)];
  [self.layer setShadowRadius:4.0f];
  [self.layer setShadowPath:[self shapeBezierPath].CGPath];
  
  [self.layer addSublayer:shapeLayer];
}

- (UIBezierPath *)shapeBezierPath{
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds
                               byRoundingCorners:UIRectCornerAllCorners
                                     cornerRadii:CGSizeMake(DEFAULT_CORNER_RADIUS, DEFAULT_CORNER_RADIUS)];
}

- (CAShapeLayer *)shapeMask {
  
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  [shapeLayer setBounds:self.bounds];
  [shapeLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
  [shapeLayer setPath:[self shapeBezierPath].CGPath];
  [shapeLayer setFillColor:[UIColor whiteColor].CGColor];
  
  return shapeLayer;
}

- (CAShapeLayer *)shapeWithBounds:(CGRect)bounds {
  
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  [shapeLayer setBounds:bounds];
  [shapeLayer setPath:[self shapeBezierPath].CGPath];
  [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
  [shapeLayer setLineWidth:DEFAULT_BORDER_WIDTH];
  
  return shapeLayer;
}

- (CAGradientLayer *)gradientLayerWithBounds:(CGRect)bounds {
  
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  [gradientLayer setBounds:bounds];
  [gradientLayer setPosition:CGPointMake(bounds.size.width/2, bounds.size.height/2)];
  
  UIColor *topColor = self.faceColor;
  UIColor *bottomColor = [self.faceColor colorWithAlphaComponent:0.5f];
  [gradientLayer setColors:[NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil]];
  
  return gradientLayer;
}

- (UIImage *)imageFromLayer:(CALayer *)layer {
  
  UIGraphicsBeginImageContext([layer frame].size);
  [layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
