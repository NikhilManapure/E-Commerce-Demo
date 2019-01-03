//
//  Category.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@class Category;

@interface Category : NSObject
@property (nonatomic, copy) NSString *name;
@property BOOL isSortingWithPrice;
@property (nonatomic, copy) NSArray<Product *> *products;

@property BOOL isExpanded;

+ (NSArray<Category *> *)getCategoriesFromJSON:(NSArray *) array;

@end
