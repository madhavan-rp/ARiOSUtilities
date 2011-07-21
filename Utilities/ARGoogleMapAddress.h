/*  GoogleMapsAddress.h
 *  Vineloop
 *
 *  Created by Scott Wasserman on 4/13/10.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

/* ******************************
 *  Portions Created by Matthew Campbell on 1/23/09.
 *  Copyright 2009 App Shop, LLC. All rights reserved.
 *  NOTE: This file is meant for educational purposes.
 *  If you choose to redistribute this file please include
 *  this information:
 *
 * ******************************
 *  This code has been created by "How to Make iPhone Apps"
 *  http://howtomakeiphoneapps.com
 *  to help you understand the basics of creating a class
 *  in Objective-C.  If you are interested in learning
 *  more please visit our website and sign up for our
 * Weekly iPhone Programming Tip of the Week:
 * http://howtomakeiphoneapps.com
 * - Matt, How to Make iPhone Apps
 * ******************************
 */

#import <MapKit/Mapkit.h>
#import <Foundation/Foundation.h>

@interface ARGoogleMapsAddress : NSObject {
	/* local instance variable declarations: */
	NSMutableArray *AnnotationList;
	NSString *Description;
	NSString *Street;
	NSString *City;
	NSString *State;
	NSString *Zip;
}

/* property definitions: */
@property (nonatomic, retain) NSMutableArray *AnnotationList;
@property (nonatomic, retain) NSString *Description;
@property (nonatomic, retain) NSString *Street;
@property (nonatomic, retain) NSString *City;
@property (nonatomic, retain) NSString *State;
@property (nonatomic, retain) NSString *Zip;

/* function and method declarations: */
- (NSString *)googleHttpLink;
- (void)openGoogleMapsAppWithThisAddress;
- (CLLocationCoordinate2D)addressLocation;
- (MKCoordinateRegion)addressRegion;
- (MKCoordinateRegion)addressRegion:(MKCoordinateSpan)span;
- (void)AddToAnnotationList:(CLLocationCoordinate2D)coordinate title:(NSString *)title;

@end

@interface AnnotationListObject : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
- (void)moveAnnotation:(CLLocationCoordinate2D)newCoordinate;
@end