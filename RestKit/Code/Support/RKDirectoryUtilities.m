//
//  RKDirectoryUtilities.m
//  RestKit
//
//  Created by Blake Watters on 12/9/11.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//

#import "RKDirectoryUtilities.h"
#import "NSBundle+RKAdditions.h"
#import "RKLog.h"

NSString * RKExecutableName(void);

NSString * RKApplicationDataDirectory(void)
{
#if TARGET_OS_IPHONE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
#else
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    
    NSArray *possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory
                                             inDomains:NSUserDomainMask];
    NSURL *appSupportDir = nil;
    NSURL *appDirectory = nil;
    
    if ([possibleURLs count] >= 1) {
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    
    if (appSupportDir) {
        appDirectory = [appSupportDir URLByAppendingPathComponent:RKExecutableName()];
        return [appDirectory path];
    }
    
    return nil;
#endif
}

NSString * RKExecutableName(void)
{
    NSString *executableName = [[[NSBundle mainBundle] executablePath] lastPathComponent];
    if (nil == executableName) {
        RKLogWarning(@"Unable to determine CFBundleExecutable: storing data under RestKit directory name.");
        executableName = @"RestKit";
    }
    
    return executableName;
}

NSString * RKCachesDirectory(void)
{
#if TARGET_OS_IPHONE
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
#else
    NSString *path = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([paths count]) {
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:RKExecutableName()];
    }
    
    return path;
#endif
}

BOOL RKEnsureDirectoryExistsAtPath(NSString *path, NSError **error)
{
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            // Exists at a path and is a directory, we're good
            if (error) *error = nil;
            return YES;
        }
    }
    
    // Create the directory and any intermediates
    NSError *errorReference = (error == nil) ? nil : *error;
    if (! [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&errorReference]) {
        RKLogError(@"Failed to create requested directory at path '%@': %@", path, errorReference);
        return NO;
    }
    
    return YES;
}
