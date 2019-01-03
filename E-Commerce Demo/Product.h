//
//  Product.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Product;

@interface Product : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger cost;
@property (nonatomic, assign) NSString *imageUrl;

+ (NSArray<Product *> *)getProductsFromJSON:(NSArray *) rawProducts;
@end
