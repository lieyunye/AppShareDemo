//
//  AppShareHelper.m
//  TestAppShare
//
//  Created by lieyunye on 5/27/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "AppShareHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@implementation AppShareHelper

+ (BOOL)checkFileIsMp4VideoFileWithFilePath:(NSString *)filePath
{
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    NSArray *videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks.count > 0) {
        return YES;
    }
    return NO;
}

+ (FileType)fileTypeWithFilePath:(NSString *)filePath
{
    FileType fileType = FileTypeUnkonw;
    CFStringRef fileExtension = (__bridge CFStringRef) [filePath pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    if (UTTypeConformsTo(fileUTI, kUTTypeImage)) fileType = FileTypeImage;
    else if (UTTypeConformsTo(fileUTI, kUTTypeMovie)) fileType = FileTypeMovie;
    else if (UTTypeConformsTo(fileUTI, kUTTypeText)) fileType = FileTypeText;
    
    CFRelease(fileUTI);
    return fileType;
}

@end
