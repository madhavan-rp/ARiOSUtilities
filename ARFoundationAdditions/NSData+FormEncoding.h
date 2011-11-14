/*  ARURLHelper.h
 *
 *  Created by Adam Duke on 7/6/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface NSData (FormEncoding)

+ (NSData *)formEncodedDataFor:(NSDictionary *)requestParameters;
@end
