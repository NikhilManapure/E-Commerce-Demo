//
//  Product.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 02/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Utility.h"

@implementation Product

+ (NSArray<Product *> *)getProductsFromJSON:(NSArray *) rawProducts {
    NSMutableArray<Product *> *products = [NSMutableArray array];
    
    for (NSDictionary* rawProduct in rawProducts) {
        NSString *name = [rawProduct valueForKey:@"name"];
        NSString *costString = [rawProduct valueForKey:@"cost"];
        if (name != nil && costString != nil) {
            [products addObject:[[Product alloc] initWithName: name andPrice: [costString integerValue]]];
        }
    }
    
    return products;
}

-(id)initWithName:(NSString *)name andPrice:(NSInteger)cost {
    self = [super init];
    self.name = name;
    self.cost = cost;
    self.imageUrl = [Utility randomImageURL];
    
    return self;
}

@end
