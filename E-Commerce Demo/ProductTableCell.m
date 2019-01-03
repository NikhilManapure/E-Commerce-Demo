//
//  ProductTableCell.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "ProductTableCell.h"
#import "Utility.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(Product *)newValue {
    _product = newValue;
    self.titleLabel.text = newValue.name;
    self.costLabel.text = [Utility asRupee: newValue.cost];
    [self.productThumbnailImageView sd_setImageWithURL:[NSURL URLWithString: newValue.imageUrl] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
}

@end
