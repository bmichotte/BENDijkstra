//
//  BENDijkstra.h
//  BENDijkstra
//
//  Created by Benjamin Michotte on 18/07/13.
//  Copyright (c) 2013 Benjamin Michotte. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BENPoint;

/**
 * This is the Objective-C implementation of the Dijkstra algorithm
 * See [Wikipedia page](http://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) for more
 */
@interface BENDijkstra : NSObject

@property (nonatomic, strong) NSArray *positions;
@property (nonatomic, strong) BENPoint *from;
@property (nonatomic, strong) BENPoint *to;

/**
 * Find the shortest path between property from and property to
 * @return An array of BENPoint.
 * @warning *Important:* If the path can not be found, the return array will be nil unless you use method shortestPath: and set empty to NO
 */
- (NSArray *)shortestPath;

/**
 * Find the shortest path between property from and property to
 * @param empty Set to NO in order to get a path even if this path is not complete
 * @return An array of BENPoint.
 */
- (NSArray *)shortestPath:(BOOL)empty;

@end
