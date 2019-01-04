//
//  ProductDetailController.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 03/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "ProductDetailController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProductDetailController ()
@property CGFloat lastScale;
@end

@implementation ProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.productImageView sd_setImageWithURL: [NSURL URLWithString:self.product.imageUrl]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.productImageView addGestureRecognizer:tapGesture];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.productImageView;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [UIView animateWithDuration: 0.3 delay: 0 options:UIViewAnimationOptionCurveLinear  animations:^{
            if (self.scrollView.zoomScale > 1) {
                self.scrollView.zoomScale = 1;
            } else {
                self.scrollView.zoomScale = 5;
            }
        } completion:^(BOOL finished) {
            //code for completion
        }];
    }
}

@end
