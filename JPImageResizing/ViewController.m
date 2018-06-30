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
@property (nonatomic, assign) CGSize resizedSize;
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ioImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = self.originImageView.image;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat w = 150 * scale;
    CGFloat h = 150 * (image.size.height / image.size.width) * scale;
    self.resizedSize = CGSizeMake(w, h);
}

- (IBAction)uiAction:(id)sender {
    self.uiImageView.image = [self.originImageView.image jp_uiResizeImageWithSize:self.resizedSize];
}

- (IBAction)cgAction:(id)sender {
    self.cgImageView.image = [self.originImageView.image jp_cgResizeImageWithSize:self.resizedSize];
}


- (IBAction)ioAction:(id)sender {
    self.ioImageView.image = [self.originImageView.image jp_ioResizeImageWithSize:self.resizedSize];
}

@end
