//
//  BENDijkstra.m
//  BENDijkstra
//
//  Created by Benjamin Michotte on 18/07/13.
//  Copyright (c) 2013 Benjamin Michotte. All rights reserved.
//

#import "BENDijkstra.h"
#import "BENPoint.h"

@interface BENDijkstraPoint : NSObject

@property (nonatomic, strong) BENPoint *point;
@property (nonatomic, assign) double weight;
@property (nonatomic, assign) BOOL passed;
@property (nonatomic, strong) BENPoint *previous;

@end

@implementation BENDijkstraPoint

@end

@interface BENDijkstra ()
{
    NSMutableDictionary *weights, *predecessors;
}

@end

@implementation BENDijkstra

- (NSArray *)shortestPath
{
    return [self shortestPath:YES];
}

- (NSArray *)shortestPath:(BOOL)empty
{
    NSAssert(self.from != nil, @"from must be set, nil found");
    NSAssert(self.to != nil, @"to must be set, nil found");
    
    weights = [NSMutableDictionary dictionary];
    predecessors = [NSMutableDictionary dictionary];
    
    for (BENPoint *point in self.positions)
    {
        BOOL passed = NO;
        double weight = -1.0;
        
        if ([point isEqual:self.from])
        {
            passed = YES;
            weight = 0.0;
        }
        
        // init weights
        BENDijkstraPoint *p = [[BENDijkstraPoint alloc] init];
        p.previous = nil;
        p.point = point;
        p.passed = passed;
        p.weight = weight;
        weights[point.ref] = p;
        
        // init predecessors
        predecessors[point.ref] = p;
    };
    
    [self run:self.from];
    
    return [self path:empty];
}

- (void)run:(BENPoint *)parent
{
    NSAssert(parent != nil, @"parent can not be nil");
    
    // we reached the final point
    if ([parent isEqual:self.to])
    {
        return;
    }
    
    // we can set this node has been passed by
    ((BENDijkstraPoint *) weights[parent.ref]).passed = YES;
    
    // search for weight between $parent and its children
    for (BENPoint *point in parent.linkedPoints)
    {
        [self calculateWeightBetween:parent and:point];
    }
    
    // search for the next parent (smallest weight)
    // we have to find the smallest weight for a node we didn't passed by atm
    double smallest = INFINITY;
    BENPoint *nextParent = nil;
    
    for (BENDijkstraPoint *w in [weights allValues])
    {
        BOOL passed = w.passed;
        double weight = w.weight;
        if (weight < smallest && weight != -1 && ! passed)
        {
            smallest = weight;
            nextParent = w.point;
        }
    }
    
    if (nextParent)
    {
        [self run:nextParent];
    }
}

- (void)calculateWeightBetween:(BENPoint *)parent and:(BENPoint*)child
{
    /*
     * Dijkstra algo :
     *
     * IF (child-node is not traversed yet) AND
     *	(WEIGHT(parent-node) + WEIGHT(DISTANCE(parent-node, child-node) < WEIGHT(child-node) OR WEIGHT(child-node) = -1)
     * THEN
     *	WEIGHT(child-node) = WEIGHT(parent-node) + WEIGHT(DISTANCE(parent-node, child-node)
     *  PREDECESSOR(child-node) = parent-node
     * ENDIF
     */
    
    BENDijkstraPoint *childD = weights[child.ref];
    BENDijkstraPoint *parentD = weights[parent.ref];
    
    BOOL passed = childD.passed;
    double childWeight = childD.weight;
    double parentWeight = parentD.weight;
    double distance = [parent distance:child];
    
    if (! passed
        && (parentWeight + distance < childWeight || childWeight == -1))
    {
        ((BENDijkstraPoint *) weights[child.ref]).weight = parentWeight + distance;
        ((BENDijkstraPoint *) predecessors[child.ref]).previous = parent;
    }
}

- (NSArray *)path:(BOOL)empty
{
    NSLog(@"%@", self.to);
    NSMutableArray *path = [NSMutableArray arrayWithObject:self.to];
    BENPoint *point = nil;
    BENPoint *previous = self.to;
    while (true)
    {
        for (BENDijkstraPoint *predecessor in [predecessors allValues])
        {
            if ([predecessor.point isEqual:previous] && predecessor.previous)
            {
                point = predecessor.previous;
                NSLog(@"%@", point);
                [path addObject:point];
                break;
            }
        }
        
        // point is nil -> path is impossible
        if (! point)
        {
            if (empty)
            {
                return nil;
            }
            [path removeLastObject];
            break;
        }
        
        if ([point isEqual:self.from])
        {
            break;
        }
        previous = point;
        point = nil;
    }
    
    return [[path reverseObjectEnumerator] allObjects];
}

@end
