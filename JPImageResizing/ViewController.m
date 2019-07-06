//
//  ViewController.m
//  JPImageResizing
//
//  Created by 周健平 on 2018/6/30.
//  Copyright © 2018 周健平. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+JPExtension.h"

@interface ViewController ()
@property (nonatomic, assign) CGFloat resizedScale;
@property (nonatomic, strong) UIImage *originImage;
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ioImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resizedScale = 0.5;
    
    UIImage *originImage = [UIImage imageNamed:[NSString stringWithFormat:@"girl@%.0lfx.jpg", [UIScreen mainScreen].scale]];
    self.originImage = originImage;
    self.originImageView.image = originImage;
    
    NSLog(@"origin size: %@, scale: %lf", NSStringFromCGSize(originImage.size), originImage.scale);
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [originImage jp_writeToFile:@"/Users/zhoujianping/Desktop/originImage.jpg" isPNGType:NO];
//    });
}

- (IBAction)uiAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *uiResizeImage0 = [self.originImage jp_uiResizeImageWithScale:self.resizedScale];
        NSLog(@"uiResizeImage0 size: %@, scale: %lf", NSStringFromCGSize(uiResizeImage0.size), uiResizeImage0.scale);

//        UIImage *uiResizeImage1 = [self.originImage jp_uiResizeImageWithLogicWidth:(self.originImage.size.width * self.resizedScale)];
//        NSLog(@"uiResizeImage1 size: %@, scale: %lf", NSStringFromCGSize(uiResizeImage1.size), uiResizeImage1.scale);

//        UIImage *uiResizeImage2 = [self.originImage jp_uiResizeImageWithPixelWidth:(self.originImage.size.width * self.originImage.scale * self.resizedScale)];
//        NSLog(@"uiResizeImage2 size: %@, scale: %lf", NSStringFromCGSize(uiResizeImage2.size), uiResizeImage2.scale);
        
//        [uiResizeImage0 jp_writeToFile:@"/Users/zhoujianping/Desktop/uiResizeImage.jpg" isPNGType:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.uiImageView.image = uiResizeImage0;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"ui耗时: %lf", finishTimeInt - beginTimeInt);
        });
    });
}

- (IBAction)cgAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *cgResizeImage0 = [self.originImage jp_cgResizeImageWithScale:self.resizedScale];
        NSLog(@"cgResizeImage0 size: %@, scale: %lf", NSStringFromCGSize(cgResizeImage0.size), cgResizeImage0.scale);
        
//        UIImage *cgResizeImage1 = [self.originImage jp_cgResizeImageWithLogicWidth:(self.originImage.size.width * self.resizedScale)];
//        NSLog(@"cgResizeImage1 size: %@, scale: %lf", NSStringFromCGSize(cgResizeImage1.size), cgResizeImage1.scale);

//        UIImage *cgResizeImage2 = [self.originImage jp_cgResizeImageWithPixelWidth:(self.originImage.size.width * self.originImage.scale * self.resizedScale)];
//        NSLog(@"cgResizeImage2 size: %@, scale: %lf", NSStringFromCGSize(cgResizeImage2.size), cgResizeImage2.scale);
        
//        [cgResizeImage0 jp_writeToFile:@"/Users/zhoujianping/Desktop/cgResizeImage.jpg" isPNGType:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cgImageView.image = cgResizeImage0;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"cg耗时: %lf", finishTimeInt - beginTimeInt);
        });
    });
}

- (IBAction)ioAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *ioResizeImage0 = [self.originImage jp_ioResizeImageWithScale:self.resizedScale isPNGType:NO];
        NSLog(@"ioResizeImage0 size: %@, scale: %lf", NSStringFromCGSize(ioResizeImage0.size), ioResizeImage0.scale);
        
//        UIImage *ioResizeImage1 = [self.originImage jp_ioResizeImageWithLogicWidth:(self.originImage.size.width * self.resizedScale) isPNGType:NO];
//        NSLog(@"ioResizeImage1 size: %@, scale: %lf", NSStringFromCGSize(ioResizeImage1.size), ioResizeImage1.scale);

//        UIImage *ioResizeImage2 = [self.originImage jp_ioResizeImageWithPixelWidth:(self.originImage.size.width * self.originImage.scale * self.resizedScale) isPNGType:NO];
//        NSLog(@"ioResizeImage2 size: %@, scale: %lf", NSStringFromCGSize(ioResizeImage2.size), ioResizeImage2.scale);
        
//        [ioResizeImage0 jp_writeToFile:@"/Users/zhoujianping/Desktop/ioResizeImage.jpg" isPNGType:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ioImageView.image = ioResizeImage0;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"io耗时: %lf", finishTimeInt - beginTimeInt);
        });
    });
}

@end
