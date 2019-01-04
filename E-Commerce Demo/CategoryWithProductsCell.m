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
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 0.2;
    [self addGestureRecognizer:longPress];
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
    return CGSizeMake(width * 0.333, height * 0.5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [collectionView convertRect:attributes.frame toView: nil];
    if ([self.delegate respondsToSelector:@selector(selectProduct:withFrame:)]) {
        [self.delegate selectProduct: self.category.products[indexPath.row] withFrame:cellFrameInSuperview];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    NSMutableArray *moveArray = [[NSMutableArray alloc] initWithArray:self.category.products];
    id obj = [self.category.products objectAtIndex:sourceIndexPath.row];
    [moveArray removeObject:obj];
    [moveArray insertObject:obj atIndex:destinationIndexPath.row];
    self.category.products = moveArray;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.productsCollectionView indexPathForItemAtPoint:[gesture locationInView: self.productsCollectionView]];
        [self.productsCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.productsCollectionView updateInteractiveMovementTargetPosition:[gesture locationInView: self.productsCollectionView]];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.productsCollectionView endInteractiveMovement];
    } else {
        [self.productsCollectionView cancelInteractiveMovement];
    }
}
@end
