/*  GoogleMapsAddress.m
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

#import "ARGoogleMapAddress.h"
#import <MapKit/Mapkit.h>

@implementation AnnotationListObject

@synthesize coordinate, title, subtitle;

- (void)moveAnnotation:(CLLocationCoordinate2D)newCoordinate
{
	coordinate = newCoordinate;
}

@end

@implementation ARGoogleMapsAddress

/* properties must be synthesized: */
@synthesize Description, Street, City, State, Zip, AnnotationList;

/* This is executed when the object is first created
 * Set up variables here
 */
- (id)init
{
	if(self = [super init])
	{
		/* Use this space to initialize variables */
		AnnotationList = [NSMutableArray new];
	}
	return self;
}

/* This is executed right before the object is released
 * Release variables here
 */
- (void)dealloc
{
	[Description release];
	[Street release];
	[City release];
	[State release];
	[Zip release];
	[super dealloc];
}

/* Returns a Google maps link based on the information here */
- (NSString *)googleHttpLink
{
	NSString *street_temp = [NSString stringWithString:self.Street];
	street_temp = [street_temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];

	NSString *city_temp = [NSString stringWithString:self.City];
	city_temp = [city_temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];

	NSString *state_temp = [NSString stringWithString:self.State];
	state_temp = [state_temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];

	NSString *zip_temp = [NSString stringWithString:self.Zip];
	zip_temp = [zip_temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];

	NSString *temp =  [NSString stringWithFormat:
	                   @"http://maps.google.com/?q=%@+%@+%@+%@",
	                   street_temp,
	                   city_temp,
	                   state_temp,
	                   zip_temp];

	return temp;
}

/* Closes the app and opens Google maps with the information here */
- (void)openGoogleMapsAppWithThisAddress
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self googleHttpLink]]];
}

- (MKCoordinateRegion)addressRegion
{
	MKCoordinateSpan span = MKCoordinateSpanMake(0.1/10, 0.1/10);
	return [self addressRegion:span];
}

- (MKCoordinateRegion)addressRegion:(MKCoordinateSpan)span
{
	CLLocationCoordinate2D coord = [self addressLocation];
	MKCoordinateRegion region = {
		coord, span
	};
	return region;
}

/* Function to geolocate the address text to a CLLocation Coordinate values */
- (CLLocationCoordinate2D)addressLocation
{
	NSString *completeAddress = [NSString stringWithFormat:@"%@, %@, %@ %@", self.Street, self.City, self.State, self.Zip];
	NSError *error;
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",
	                       [completeAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];

	double latitude = 0.0;
	double longitude = 0.0;
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"])
	{
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else
	{
		/* Show error */
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;

	return location;
}

- (void)AddToAnnotationList:(CLLocationCoordinate2D)coordinate title:(NSString *)title
{
	AnnotationListObject *newAnnotation = [AnnotationListObject new];
	[newAnnotation setCoordinate:coordinate];
	[newAnnotation setTitle:title];
	[newAnnotation setSubtitle:@""];
	[self.AnnotationList addObject:newAnnotation];
	[newAnnotation release];
}

@end
