//
//  ProductTableCell.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productThumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@property (strong, nonatomic) Product *product;

@end
