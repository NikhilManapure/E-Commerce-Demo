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
    // http://www.stickpng.com/img/clothes/hoodies/85-south-hoodie
    NSArray *urls = [NSArray arrayWithObjects:
                     @"http://www.stickpng.com/assets/thumbs/58e38cda204d556bbd97b15e.png",
                     @"http://www.stickpng.com/assets/thumbs/58ee81d93545163ec1942cba.png",
                     @"http://www.stickpng.com/assets/thumbs/58e38cd2204d556bbd97b15d.png",
                     @"http://www.stickpng.com/assets/thumbs/58e38ce2204d556bbd97b15f.png",
                     @"http://www.stickpng.com/assets/thumbs/58e38dc4204d556bbd97b166.png",
                     @"http://www.stickpng.com/assets/thumbs/58e38e1a204d556bbd97b167.png",
                     @"http://www.stickpng.com/assets/thumbs/58e38d0a204d556bbd97b163.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf1b.png",
                     @"http://www.stickpng.com/assets/thumbs/585680404f6ae202fedf26f0.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf22.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf28.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf30.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf30.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf31.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf32.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf52.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf53.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf5a.png",
                     @"http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf60.png"
                     , nil];
    return urls[arc4random_uniform((unsigned int)urls.count)];
}
@end
