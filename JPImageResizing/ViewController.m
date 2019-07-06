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
@property (nonatomic, strong) UIImage *originImage;
@property (nonatomic, assign) CGFloat resizedScale;
@property (nonatomic, assign) CGSize resizedSize;
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ioImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.originImage = self.originImageView.image;
    self.resizedScale = 1;
    
    CGFloat w = 300;
    CGFloat h = 300 * (self.originImage.size.height / self.originImage.size.width);
    self.resizedSize = CGSizeMake(w, h);
}

- (IBAction)uiAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self.originImage jp_uiResizeImageWithSize:self.resizedSize scale:self.resizedScale];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.uiImageView.image = image;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"size: %@, ui耗时: %lf", NSStringFromCGSize(image.size), finishTimeInt - beginTimeInt);
        });
    });
}

- (IBAction)cgAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self.originImage jp_cgResizeImageWithSize:self.resizedSize scale:self.resizedScale];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cgImageView.image = image;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"size: %@, cg耗时: %lf", NSStringFromCGSize(image.size), finishTimeInt - beginTimeInt);
        });
    });
}

- (IBAction)ioAction:(id)sender {
    NSTimeInterval beginTimeInt = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self.originImage jp_ioResizeImageWithSize:self.resizedSize scale:self.resizedScale];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ioImageView.image = image;
            NSTimeInterval finishTimeInt = [[NSDate date] timeIntervalSince1970];
            NSLog(@"size: %@, io耗时: %lf", NSStringFromCGSize(image.size), finishTimeInt - beginTimeInt);
        });
    });
}

@end
