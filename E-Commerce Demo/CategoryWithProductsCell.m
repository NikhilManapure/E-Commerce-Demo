//
//  CategoryWithProductsCell.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 01/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "CategoryWithProductsCell.h"
#import "ProductCell.h"
#import "AllProductsController.h"

@implementation CategoryWithProductsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.productsCollectionView registerNib:[UINib nibWithNibName: @"ProductCell" bundle: nil] forCellWithReuseIdentifier:@"ProductCell"];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [collectionView convertRect:attributes.frame toView: nil];
    if ([self.delegate respondsToSelector:@selector(selectProduct:withFrame:)]) {
        [self.delegate selectProduct: self.category.products[indexPath.row] withFrame:cellFrameInSuperview];
    }
    
//    UIImageView *view = [[UIImageView alloc] initWithFrame:cellFrameInSuperview];
//    view.contentMode = UIViewContentModeScaleAspectFit;
//    [view sd_setImageWithURL:[NSURL URLWithString: self.category.products[indexPath.row].imageUrl] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
//    [[self.delegate view] addSubview:view];
//    
//    CGRect fullScreenRect = [UIScreen.mainScreen bounds];
//    CGFloat ht = [self.delegate navigationController].navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
//    fullScreenRect.origin.y = fullScreenRect.origin.y + ht;
//    fullScreenRect.size.height = fullScreenRect.size.height - ht;
//    
//    [UIView animateWithDuration: 0.2 delay: 0 options: UIViewAnimationOptionCurveLinear  animations:^{
//        [view setFrame: [self.delegate view].frame];
//        [view setFrame: fullScreenRect];
//        [view setBackgroundColor:[UIColor whiteColor]];
//    } completion:^(BOOL finished) {
//        
//        [view removeFromSuperview];
//    }];
}

@end
