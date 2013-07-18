# BENDijkstra

This is an Objective-C implementation of the [Dijkstra algorithm](http://en.wikipedia.org/wiki/Dijkstra%27s_algorithm).

The code is tested on iOS 6 and requires ARC. It should work on Mac OS X as well (not tested).

Released under the [MIT License](LICENSE)

## Usage

``` objc
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

NSArray *points = @[ p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 ];

BENDijkstra *dijkstra = [[BENDijkstra alloc] init];
// let search from p1 to p8
dijkstra.from = p1;
dijkstra.to = p8;
dijkstra.positions = points;
NSArray *path = [dijkstra shortestPath];
NSLog(@"From %@", p1);
NSLog(@"To %@", p8);
NSLog(@"Path is %@", path);

/*
 This will output the following
 From [BENPoint(x:57, y:10, ref:57-10)] 
 To: [BENPoint(x:4, y:90, ref:4-90)] 
 Path is : (
    "[BENPoint(x:57, y:10, ref:57-10)]",
    "[BENPoint(x:52, y:24, ref:52-24)]",
    "[BENPoint(x:78, y:20, ref:78-20)]"
 )
*/
```

## Installation

Simply add the files in the `BENDijkstra` directory to your project.
