//
//  RKRoute.m
//  RestKit
//
//  Created by Blake Watters on 5/31/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
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

#import "RKRoute.h"

@interface RKRoute ()
@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, retain, readwrite) Class objectClass;
@property (nonatomic, assign, readwrite) RKRequestMethod method;
@property (nonatomic, retain, readwrite) NSString *resourcePathPattern;
@end

@interface RKNamedRoute : RKRoute
@end

@interface RKClassRoute : RKRoute
@end

@interface RKRelationshipRoute : RKRoute
@end

@implementation RKRoute

@synthesize name = _name;
@synthesize objectClass = _objectClass;
@synthesize method = _method;
@synthesize resourcePathPattern = _resourcePathPattern;
@synthesize shouldEscapeResourcePath = _shouldEscapeResourcePath;

+ (id)routeWithName:(NSString *)name resourcePathPattern:(NSString *)resourcePathPattern method:(RKRequestMethod)method
{
    NSParameterAssert(name);
    NSParameterAssert(resourcePathPattern);
    RKNamedRoute *route = [[RKNamedRoute new] autorelease];
    route.name = name;
    route.resourcePathPattern = resourcePathPattern;
    route.method = method;
    return route;
}

+ (id)routeWithClass:(Class)objectClass resourcePathPattern:(NSString *)resourcePathPattern method:(RKRequestMethod)method
{
    NSParameterAssert(objectClass);
    NSParameterAssert(resourcePathPattern);
    RKClassRoute *route = [[RKClassRoute new] autorelease];
    route.objectClass = objectClass;
    route.resourcePathPattern = resourcePathPattern;
    route.method = method;
    return route;
}

+ (id)routeWithRelationshipName:(NSString *)relationshipName objectClass:(Class)objectClass resourcePathPattern:(NSString *)resourcePathPattern method:(RKRequestMethod)method
{
    NSParameterAssert(relationshipName);
    NSParameterAssert(objectClass);
    RKRelationshipRoute *route = [[RKRelationshipRoute new] autorelease];
    route.name = relationshipName;
    route.objectClass = objectClass;
    route.resourcePathPattern = resourcePathPattern;
    route.method = method;
    return route;
}

- (id)init
{
    self = [super init];
    if (self) {
        if ([self isMemberOfClass:[RKRoute class]]) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[NSString stringWithFormat:@"%@ is not meant to be directly instantiated. Use one of the initializer methods instead.",
                                                   NSStringFromClass([self class])]
                                         userInfo:nil];
        }
    }

    return self;
}

- (BOOL)isNamedRoute
{
    return NO;
}

- (BOOL)isClassRoute
{
    return NO;
}

- (BOOL)isRelationshipRoute
{
    return NO;
}

@end

@implementation RKNamedRoute

- (BOOL)isNamedRoute
{
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p name=%@ method=%@ resourcePathPattern=%@>",
            NSStringFromClass([self class]), self, self.name, RKStringFromRequestMethod(self.method), self.resourcePathPattern];
}

@end

@implementation RKClassRoute

- (BOOL)isClassRoute
{
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p objectClass=%@ method=%@ resourcePathPattern=%@>",
            NSStringFromClass([self class]), self, NSStringFromClass(self.objectClass),
            RKStringFromRequestMethod(self.method), self.resourcePathPattern];
}

@end

@implementation RKRelationshipRoute

- (BOOL)isRelationshipRoute
{
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p relationshipName=%@ objectClass=%@ method=%@ resourcePathPattern=%@>",
            NSStringFromClass([self class]), self, self.name, NSStringFromClass(self.objectClass),
            RKStringFromRequestMethod(self.method), self.resourcePathPattern];
}

@end
