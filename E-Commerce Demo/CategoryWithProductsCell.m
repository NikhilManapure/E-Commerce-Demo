//
//  CategoryWithProductsCell.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "CategoryWithProductsCell.h"
#import "ProductCell.h"

@implementation CategoryWithProductsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.productsCollectionView registerNib:[UINib nibWithNibName: @"ProductCell" bundle: nil] forCellWithReuseIdentifier:@"ProductCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.category.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ProductCell" forIndexPath: indexPath];
    cell.product = self.category.products[indexPath.row];
    return cell;
}

- (IBAction)sortingChanged:(UISegmentedControl *)sender {
    self.category.isSortingWithPrice = sender.selectedSegmentIndex == 0;
    self.category.products = [self.category.products sortedArrayUsingComparator:^NSComparisonResult(Product* a, Product* b) {
        if (self.category.isSortingWithPrice) {
            return a.cost > b.cost;
        } else {
            return [a.name compare: b.name];
        }
    }];
    [self.productsCollectionView reloadData];
}

- (void)setCategory: (Category *)newValue {
    _category = newValue;
    self.titleLabel.text = newValue.name;
    [self.productsCollectionView reloadData];
    self.sortingSegmentedControl.selectedSegmentIndex = self.category.isSortingWithPrice ? 0 : 1;
    [self sortingChanged: self.sortingSegmentedControl];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.productsCollectionView.frame.size.height;
    CGFloat width  = self.productsCollectionView.frame.size.width;
    return CGSizeMake(width * 0.33, height * 0.5);
}

@end
