//
//  ProductCell.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "ProductCell.h"
#import "Utility.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setProduct:(Product *)newValue {
    _product = newValue;
    self.titleLabel.text = newValue.name;
    self.costLabel.text = [Utility asRupee: newValue.cost];
    
    [self.productThumbnailImageView sd_setImageWithURL:[NSURL URLWithString: newValue.imageUrl] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
}

@end
