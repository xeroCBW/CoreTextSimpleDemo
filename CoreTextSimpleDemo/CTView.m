//
//  CTView.m
//  CoreTextSimpleDemo
//
//  Created by 陈博文 on 16/11/6.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>

@implementation CTView


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self demo2];
}



- (void)demo1{
    
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 步骤 4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World!"];
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    // 步骤 5
    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

//所以我们在做 drawRect 方法的时候,需要提前将 frame 计算好,这样可以避免不是我们想要的效果


/**
 如果文本不够宽,会自动往下进行排布的,相当于 UILabel 进行自动布局
 */


//图片是使用空白占位符进行占位的---// 使用0xFFFC作为空白的占位符
- (void)demo2{
    

    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    // 步骤 4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World! "
                                     " 创建绘制的区域，CoreText 本身支持各种文字排版的区域,"
                                     "-------------------------------"
                                     " 我们这里简单地将 UIView 的整个界面作为排版的区域。"
                                     " 为了加深理解，建议读者将该步骤的代码替换成如下代码，"
                                     " 测试设置不同的绘制区域带来的界面变化。"];
    

    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    // 步骤 5
    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
  
}

@end
