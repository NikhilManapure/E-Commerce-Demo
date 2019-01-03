//
//  CategorySectionCell.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "CategorySectionCell.h"

@implementation CategorySectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCategory: (Category *)newValue {
    _category = newValue;
    self.categoryTitleLabel.text = newValue.name;
    if (newValue.isExpanded) {
        self.openCloseImageView.image = [UIImage imageNamed:@"openArrow"];
    } else {
        self.openCloseImageView.image = [UIImage imageNamed:@"closeArrow"];
    }
}

@end
