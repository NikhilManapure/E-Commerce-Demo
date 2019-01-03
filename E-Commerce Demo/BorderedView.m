//
//  BorderedView.m
//  E-Commerce Demo
//
//  Created by Evolusolve on 03/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

#import "BorderedView.h"

@implementation BorderedView


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.15f] CGColor] ;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5.0f;
    }
    return self;
}

@end
