//
//  HYLocalPathManager.m
//
//  Created by oceanMAC on 2023/2/14.
//

#import "HYLocalPathManager.h"

@implementation HYLocalPathManager

#pragma mark - Public
/**
 文件根目录
 @return 文件根目录
 */
+ (NSString *)funVideoRootPath:(NSString *)fileName
{
    NSString *videoRootPath = [[self rootPath] stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:videoRootPath]) {
        NSError *error = nil;
        [manager createDirectoryAtPath:videoRootPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建目录失败");
        }
        else {
            return videoRootPath;
        }
    }
    return videoRootPath;
}

+ (BOOL)createPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        NSError *error = nil;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建目录失败");
            return NO;
        }
        else {
            return YES;
        }
    }
    return YES;
}

//图片保存
//+ (NSString *)photoSave:(UIImage *)image
//{
//    NSString *recordDir = [self funVideoRootPath:@"ImageList"];
//
//    NSString *newTime = [LHYConfig getCurrentTimes];
//    NSString *filePath = [recordDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",newTime]];
//
//    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];//保存图片到沙盒
//    return newTime;
//}


//保存data  xxxx/book/bookid/chapterID.text
+ (NSString *)SaveData:(NSData *)data bookId:(NSString *)bookId chapterId:(NSString *)chapterId
{

    NSString *videoRootPath = [self funVideoRootPath:@"book"];
    NSString *filePath1 = [videoRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",bookId]];
    BOOL is = [self createPath:filePath1];
    if (is) {
        NSString *filePath = [filePath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",chapterId]];

        BOOL ss = [data writeToFile:filePath atomically:YES];
        if (ss) {
            return filePath;
        }
        NSLog(@"保存路径:%@",filePath);
        return @"";
    }
    return @"";
}

+ (NSString *)getBookFilePathBookId:(NSString *)bookId chapterId:(NSString *)chapterId {
    NSString *videoRootPath = [self funVideoRootPath:@"book"];
    NSString *filePath1 = [videoRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",bookId]];
    NSString *filePath = [filePath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",chapterId]];
    return filePath;
}

+ (NSString *)getBookFilePath:(NSString *)name {
    NSString *videoRootPath = [self funVideoRootPath:@"book"];
    NSString *filePath1 = [videoRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    NSString *filePath = [filePath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",name]];
    return filePath;
}
/**
 清除目录
 @dirPath 文件路径
 */
+ (void)clearDir:(NSString *)dirPath {
    [[NSFileManager defaultManager] removeItemAtPath:dirPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 生成随机字符串
 @return 随机字符串
 */
+ (NSString*)uuidString {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/**
 创建视频录制保存的路径
 */
+ (NSString *)createRecrodDir {
    
    NSString *recordPath = [[self funVideoRootPath:@"MusicList"] stringByAppendingPathComponent:@"record"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:recordPath]) {
        NSError *error = nil;
        [manager createDirectoryAtPath:recordPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"目录创建失败");
        }
        else {
            return recordPath;
        }
    }
    return recordPath;
}

/**
 创建视频导出的路径
 */
+ (NSString *)createExportDir {
    NSString *exportPath = [[self funVideoRootPath:@""] stringByAppendingPathComponent:@"export"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:exportPath]) {
        NSError *error = nil;
        [manager createDirectoryAtPath:exportPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"目录创建失败");
        }
        else {
            return exportPath;
        }
    }
    return exportPath;
}

#pragma mark - Private

/**
 Documents路径
 */
+ (NSString *)rootPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

/**
 Caches路径
 */
+ (NSString *)cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

//读取文件夹
+ (NSArray *)readVideoRootPath
{
    NSString *videoRootPath = [[self rootPath] stringByAppendingPathComponent:@"MusicList"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:videoRootPath]) {
        NSError *error = nil;
        NSArray *arr = [manager contentsOfDirectoryAtPath:videoRootPath error:&error];

        if (arr.count == 0) {
            return @[];
        }
        else {
            return arr;
        }
    }
    return @[];
}

//读取图片
+ (UIImage *)GetPhoto:(NSString *)name
{
    NSString *videoRootPath = [[self rootPath] stringByAppendingPathComponent:@"ImageList"];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",videoRootPath,name]];
    return image;
}


//获取当前的时间
+ (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

// 字符串转时间戳 如：2017-4-10 17:15:10 （精确到毫秒*1000）
+ (NSString *)getTimeStrWithString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

+ (NSString *)saveLocalImage:(UIImage *)image {

    NSString *path = [self funVideoRootPath:@"Images"];
    NSString *name = [NSString stringWithFormat:@"%@.png",[self randomString:16]];
    NSString *filePath = [path stringByAppendingPathComponent:name];

    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];//保存图片到沙盒

    return name;
}

+ (NSString *)getImageFilePath:(NSString *)imagePath {
    
    NSString *path = [self funVideoRootPath:@"Images"];
    NSString *filePath = [path stringByAppendingPathComponent:imagePath];
    return filePath;
}

+ (NSString *)randomString:(NSInteger)len {
    
    NSString *characters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];

    for (NSUInteger i = 0; i < len; i++) {
        NSUInteger index = arc4random_uniform((uint32_t)[characters length]);
        unichar character = [characters characterAtIndex:index];
        [randomString appendFormat:@"%C", character];
    }

    return randomString;
}

+ (NSArray <LTLoveTempModel *>*)getLoveListWithFilePath
{
    NSMutableArray <LTLoveTempModel *>* array = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lianaiqingdan" ofType:@"plist"];
    
    NSArray *tempArr = [NSArray arrayWithContentsOfFile:filePath];
    
    for (int i = 0; i < tempArr.count; i++) {
        NSDictionary *item = tempArr[i];
        NSString *typeName = item[@"name"];
        NSArray *desArr = item[@"des"];
        
        for (NSDictionary *desItem in desArr) {
            LTLoveTempModel *itemModel = [LTLoveTempModel new];
            itemModel.typeName = typeName;
            itemModel.type = i + 1;
            itemModel.imageName = desItem[@"img"];
            itemModel.name = desItem[@"title"];
            [array addObject:itemModel];
        }
    }

    return array;
}

+ (NSString *)randomGeyan
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"geyan" ofType:@"plist"];
    
    NSArray *tempArr = [NSArray arrayWithContentsOfFile:filePath];
    
    NSUInteger randomValue = arc4random_uniform(tempArr.count); // 生成 0 到 99 之间的随机数

    return tempArr[randomValue];
}

@end
