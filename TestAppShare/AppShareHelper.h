//
//  AppShareHelper.h
//  TestAppShare
//
//  Created by lieyunye on 5/27/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FileTypeUnkonw,
    FileTypeText,
    FileTypeImage,
    FileTypeMovie,
} FileType;

@interface AppShareHelper : NSObject
+ (BOOL)checkFileIsMp4VideoFileWithFilePath:(NSString *)filePath;
+ (FileType)fileTypeWithFilePath:(NSString *)filePath;

@end
