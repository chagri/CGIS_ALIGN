//
//  RKMappingResult.h
//  RestKit
//
//  Created by Blake Watters on 5/7/11.
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

@interface RKMappingResult : NSObject

- (id)initWithDictionary:(id)dictionary;
+ (RKMappingResult *)mappingResultWithDictionary:(NSDictionary *)keyPathToMappedObjects;

/**
 Return the mapping result as a dictionary
 */
- (NSDictionary *)asDictionary;
- (id)asObject;
- (NSArray *)asCollection;
- (NSError *)asError;

@end
