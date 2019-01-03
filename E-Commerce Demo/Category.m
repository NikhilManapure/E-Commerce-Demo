//
//  Category.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@implementation Category

+ (NSArray<Category *> *)getCategoriesFromJSON:(NSArray *) array {
    NSMutableArray<Category *> *categories = [NSMutableArray array];
    
    for (NSDictionary* rawCategory in array) {
        NSString *name = [rawCategory valueForKey:@"name"];
        NSArray *rawProducts = [rawCategory valueForKey:@"products"];
        if (name != nil && rawProducts != nil && rawProducts.count > 0) {
            [categories addObject:[[Category alloc] initWithName: name andProductsJSON: rawProducts]];
        }
    }
    
    return categories;
}

-(id)initWithName:(NSString *)name andProductsJSON:(NSArray *)rawProducts {
    self = [super init];
    self.name = name;
    self.products = [Product getProductsFromJSON: rawProducts];
    self.isSortingWithPrice = NO;
    return self;
}

@end
