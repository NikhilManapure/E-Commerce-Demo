//
//  CategorySectionCell.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategorySectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (strong, nonatomic) Category *category;
@property (weak, nonatomic) IBOutlet UIImageView *openCloseImageView;

@end
