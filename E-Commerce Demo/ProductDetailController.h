//
//  ProductDetailController.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 03/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) Product *product;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
