//
//  BENPoint.h
//  BENDijkstra
//
//  Created by Benjamin Michotte on 18/07/13.
//  Copyright (c) 2013 Benjamin Michotte. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class represent a point with x and y coordinates.
 * It also contains links to other points.
 */
@interface BENPoint : NSObject

/** 
 Convenient initializer
 */
+ (BENPoint *)pointWithX:(NSInteger)x y:(NSInteger)y;

/** The X coordinate of the point */
@property (nonatomic, assign) NSInteger x;

/** The Y coordinate of the point */
@property (nonatomic, assign) NSInteger y;

/** The BMPoints linked to this point */
@property (nonatomic, readonly) NSArray *linkedPoints;

/** Identify the point by the concatenation of x and y */
@property (nonatomic, readonly) NSString *ref;

/**
 * Add a link between two points
 * @param point The BMPoint to link with
 */
- (void)addLinkedPoint:(BENPoint *)point;

/**
 * Find the distance between two BMPoint
 * @param point The other point
 * @return double The distance
 */
- (double)distance:(BENPoint *)point;

@end
