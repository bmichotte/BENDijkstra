//
//  BENDijkstraTests.m
//  BENDijkstraTests
//
//  Created by Benjamin Michotte on 18/07/13.
//  Copyright (c) 2013 Benjamin Michotte. All rights reserved.
//

#import "BENDijkstraTests.h"
#import "BENDijkstra.h"
#import "BENPoint.h"

@implementation BENDijkstraTests

#pragma mark - Fixed path
- (NSArray *)path
{
    // Create an array of BENPoint
    // This will represent your "map"
    BENPoint *p1 = [BENPoint pointWithX:57 y:10];
    BENPoint *p2 = [BENPoint pointWithX:25 y:13];
    BENPoint *p3 = [BENPoint pointWithX:38 y:4];
    BENPoint *p4 = [BENPoint pointWithX:12 y:36];
    BENPoint *p5 = [BENPoint pointWithX:40 y:31];
    BENPoint *p6 = [BENPoint pointWithX:52 y:24];
    BENPoint *p7 = [BENPoint pointWithX:69 y:7];
    BENPoint *p8 = [BENPoint pointWithX:78 y:20];
    BENPoint *p9 = [BENPoint pointWithX:36 y:4];
    BENPoint *p10 = [BENPoint pointWithX:1 y:40];
    BENPoint *p11 = [BENPoint pointWithX:4 y:90];
        
    // add links between points
    [p1 addLinkedPoint:p6];
    [p1 addLinkedPoint:p9];
    
    [p2 addLinkedPoint:p9];
    [p2 addLinkedPoint:p3];
    
    [p3 addLinkedPoint:p5];
    [p3 addLinkedPoint:p9];
    
    [p4 addLinkedPoint:p10];
    [p4 addLinkedPoint:p2];
    
    [p5 addLinkedPoint:p6];
    [p5 addLinkedPoint:p1];
    
    [p6 addLinkedPoint:p7];
    [p6 addLinkedPoint:p8];
    
    [p7 addLinkedPoint:p8];
    
    return @[ p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 ];
}

- (void)testFixedPath
{
    NSArray *points = [self path];
    
    BENDijkstra *dijkstra = [[BENDijkstra alloc] init];
    // let search from p1 to p8
    dijkstra.from = points[0];
    dijkstra.to = points[7];
    dijkstra.positions = points;
    NSArray *path = [dijkstra shortestPath];
        
    STAssertNotNil(path, @"path is nil");
    NSLog(@"from: %@, to: %@ path: %@", points[0], [points lastObject], path);
}

- (void)testNoPathAvailablePath
{
    NSArray *points = [self path];
    
    BENDijkstra *dijkstra = [[BENDijkstra alloc] init];
    // let search from p1 to p11
    dijkstra.from = points[0];
    dijkstra.to = points[10];
    dijkstra.positions = points;
    NSArray *path = [dijkstra shortestPath];
    
    STAssertNil(path, @"path is not nil");
    NSLog(@"from: %@, to: %@ path: %@", points[0], [points lastObject], path);
}

@end
