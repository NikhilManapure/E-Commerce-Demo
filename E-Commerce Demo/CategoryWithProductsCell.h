//
//  CategoryWithProductsCell.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategoryWithProductsCell : UITableViewCell {
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingSegmentedControl;
@property (strong, nonatomic) Category *category;
@property id delegate;

@end
