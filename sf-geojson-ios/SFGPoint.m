//
//  SFGPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPoint.h"

@implementation SFGPoint

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPosition: (SFGPosition *) position{
    self = [super init];
    if(self != nil){
        _position = position;
    }
    return self;
}

-(instancetype) initWithPoint: (SFPoint *) point{
    self = [super init];
    if(self != nil){
        [self setPoint:point];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_POINT;
}

-(SFGeometry *) geometry{
    return [self point];
}

-(SFPoint *) point{
    return [SFGPoint pointFromPosition:_position];
}

-(void) setPoint: (SFPoint *) point{
    _position = [SFGPoint positionFromPoint:point];
}

-(NSArray *) coordinates{
    return [SFGPoint coordinatesFromPosition:_position];
}

-(void) setCoordinates: (NSArray *) coordinates{
    _position = [SFGPoint positionFromCoordinates:coordinates];
}

+(NSArray *) coordinatesFromPoint: (SFPoint *) point{
    SFGPosition *position = [self positionFromPoint:point];
    return [self coordinatesFromPosition:position];
}

+(NSArray *) coordinatesFromPosition: (SFGPosition *) position{
    return [position coordinates];
}

+(SFPoint *) pointFromCoordinates: (NSArray *) coordinates{
    SFGPosition *position = [self positionFromCoordinates:coordinates];
    return [self pointFromPosition:position];
}

+(SFPoint *) pointFromPosition: (SFGPosition *) position{
    return [position toSimplePoint];
}

+(SFGPosition *) positionFromCoordinates: (NSArray *) coordinates{
    return [[SFGPosition alloc] initWithCoordinates:coordinates];
}

+(SFGPosition *) positionFromPoint: (SFPoint *) point{
    return [[SFGPosition alloc] initWithPoint:point];
}

@end
