//
//  RKObjectPropertyInspector.h
//  RestKit
//
//  Created by Blake Watters on 3/4/10.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>

@class NSEntityDescription;

@interface RKPropertyInspector : NSObject {
  @protected
    NSCache *_propertyNamesToTypesCache;
}

+ (RKPropertyInspector *)sharedInspector;

/**
 * Returns a dictionary of names and types for the properties of a given class
 */
- (NSDictionary *)propertyNamesAndTypesForClass:(Class)objectClass;

/**
 Returns the Class type of the specified property on the object class
 */
- (Class)typeForProperty:(NSString *)propertyName ofClass:(Class)objectClass;

/**
 Returns the name of a property when provided the name of a property obtained
 via the property_getAttributes reflection API
 */
+ (NSString *)propertyTypeFromAttributeString:(NSString *)attributeString;

@end
