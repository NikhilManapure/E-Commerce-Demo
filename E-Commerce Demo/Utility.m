//
//  Utility.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 03/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)asRupee:(NSInteger)amount {
    return [NSString stringWithFormat: @"₹ %ld" ,(long)amount];
}


+ (NSString *)randomImageURL {
    NSArray *urls = [NSArray arrayWithObjects:
                    @"http://www.stickpng.com/assets/thumbs/58e38cda204d556bbd97b15e.png",
                    @"http://www.stickpng.com/assets/thumbs/58ee81d93545163ec1942cba.png",
                    @"http://www.stickpng.com/assets/thumbs/58e38cd2204d556bbd97b15d.png",
                    @"http://www.stickpng.com/assets/thumbs/58e38ce2204d556bbd97b15f.png",
                    @"http://www.stickpng.com/assets/thumbs/58e38dc4204d556bbd97b166.png",
                    @"http://www.stickpng.com/assets/thumbs/58e38e1a204d556bbd97b167.png",
                    @"http://www.stickpng.com/assets/thumbs/58e38d0a204d556bbd97b163.png"
    , nil];
    return urls[arc4random_uniform((unsigned int)urls.count)];
}
@end
