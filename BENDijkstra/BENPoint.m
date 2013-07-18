//
//  BENPoint.m
//  BENDijkstra
//
//  Created by Benjamin Michotte on 18/07/13.
//  Copyright (c) 2013 Benjamin Michotte. All rights reserved.
//

#import "BENPoint.h"

@interface BENPoint ()
{
    NSMutableSet *_linkedPoints;
}
@end

@implementation BENPoint

+ (BENPoint *)pointWithX:(NSInteger)x y:(NSInteger)y
{
    BENPoint *point = [[BENPoint alloc] init];
    point.x = x;
    point.y = y;
    return point;
}

- (id)init
{
    if (self = [super init])
    {
        _linkedPoints = [NSMutableSet set];
    }
    return self;
}

- (NSString *)ref
{
    return [NSString stringWithFormat:@"%d-%d", self.x, self.y];
}

- (void)addLinkedPoint:(BENPoint *)point
{
    [_linkedPoints addObject:point];
    
    // also add the reverse
    [point->_linkedPoints addObject:self];
}

- (NSArray *)linkedPoints
{
    return [_linkedPoints allObjects];
}

- (double)distance:(BENPoint *)point
{
    // distance = square root of ((x2 - x1)^2 + (y2 - y1)^2)
    return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2));
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[BENPoint class]])
    {
        return [((BENPoint *) object).ref isEqualToString:self.ref];
    }
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[BENPoint(x:%d, y:%d, ref:%@)]", self.x, self.y, self.ref];
}

@end
