//
//  SFGGeometry.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"
#import "SFGeometry.h"

/**
 * Coordinates key
 */
extern NSString * const SFG_COORDINATES;

/**
 * Geometry
 */
@interface SFGGeometry : SFGGeoJSONObject

/**
 * Get the simple geometry
 *
 * @return simple geometry
 */
-(SFGeometry *) geometry;

/**
 * Get the JSON object coordinates
 *
 * @return coordinates
 */
-(NSArray *) coordinates;

/**
 * Set the coordinates
 *
 * @param coordinates coordinate positions
 */
-(void) setCoordinates: (NSArray *) coordinates;

/**
 * Get the JSON object coordinates from the JSON tree
 *
 * @return coordinates
 */
+(NSArray *) treeCoordinates: (NSDictionary *) tree;

@end
