//
//  Utility.h
//  E-Commerce Demo
//
//  Created by Evolusolve on 03/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Product.h"

@protocol ProductSelectionProtocol <NSObject>
- (void)selectProduct:(Product *)product withFrame:(CGRect)cellFrameInSuperview;

@end

@interface Utility : NSObject

+ (NSString *)asRupee:(NSInteger)amount;
+ (NSString *)randomImageURL;

@end
