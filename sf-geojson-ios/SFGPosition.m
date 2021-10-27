//
//  SFGPosition.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPosition.h"

@implementation SFGPosition

-(instancetype) initWithPoint: (SFPoint *) point{
    return [self initWithLongitude:point.x andLatitude:point.y andAltitude:point.z andAdditional:point.m];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:nil];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditionals:nil];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditional: (NSDecimalNumber *) additionalElement{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditionals:[NSArray arrayWithObjects:additionalElement, nil]];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements{
    self = [super init];
    if(self != nil){
        
        if (longitude == nil || latitude == nil) {
            _coordinates = [NSMutableArray array];
        } else if (altitude == nil) {
            _coordinates = [NSMutableArray arrayWithObjects:longitude, latitude, nil];
        } else {
            _coordinates = [NSMutableArray arrayWithObjects:longitude, latitude, altitude, nil];
            if(additionalElements != nil && additionalElements.count > 0){
                for(NSDecimalNumber *element in additionalElements){
                    if([element isEqualToNumber:[NSDecimalNumber notANumber]]){
                        [NSException raise:@"NAN" format:@"No additional elements may be NaN."];
                    }
                    [_coordinates addObject:element];
                }
            }
        }
        
    }
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super init];
    if(self != nil){
        _coordinates = [NSMutableArray array];
        for(NSNumber *number in coordinates){
            [_coordinates addObject:[[NSDecimalNumber alloc] initWithDouble:[number doubleValue]]];
        }
    }
    return self;
}

-(BOOL) hasAdditionalElements{
    return _coordinates.count > 3;
}

-(NSArray<NSDecimalNumber *> *) additionalElements{
    return [_coordinates subarrayWithRange:NSMakeRange(3, _coordinates.count - 3)];
}

-(NSDecimalNumber *) x{
    return _coordinates.count > 0 ? [_coordinates objectAtIndex:0] : nil;
}

-(NSDecimalNumber *) y{
    return _coordinates.count > 1 ? [_coordinates objectAtIndex:1] : nil;
}

-(NSDecimalNumber *) z{
    return [self hasZ] ? [_coordinates objectAtIndex:2] : nil;
}

-(NSDecimalNumber *) m{
    return [self hasM] ? [_coordinates objectAtIndex:3] : nil;
}

-(BOOL) hasZ{
    return _coordinates.count > 2;
}

-(BOOL) hasM{
    return _coordinates.count > 3;
}

-(SFPoint *) toSimplePoint{
    SFPoint *point = nil;
    NSDecimalNumber *x = [self x];
    NSDecimalNumber *y = [self y];
    if(x != nil && y != nil){
        point = [[SFPoint alloc] initWithX:x andY:y andZ:[self z] andM:[self m]];
    }
    return point;
}

@end
