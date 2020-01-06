#import <Foundation/Foundation.h>
#import <objc/Object.h>
#import <objc/objc.h>

@interface NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter;
@end

@implementation NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter {
    NSNumber *number = [formatter numberFromString:self];

    if (number == nil) {
        [NSException raise:@"Bad Input" format:@"%@", self];
    }

    return number;
}
@end

@interface NSString (ArrayFromString)
- (NSArray *) arrayFromString;
@end

@implementation NSString (ArrayFromString)
- (NSArray *) arrayFromString {
    return [self componentsSeparatedByString:@" "];
}
@end

@interface Solution:NSObject
- (NSNumber *) hurdleRace:(NSNumber *)jumpValue height:(NSArray *)heightsArray;
@end

@implementation Solution
// Complete the hurdleRace function below.
- (NSNumber *) hurdleRace:(NSNumber *)jumpValue height:(NSArray *)heightsArray {
    NSNumber *maxHurdleHeight = [heightsArray valueForKeyPath:@"@max.self"];
    if ([jumpValue intValue] < [maxHurdleHeight intValue]) {
        return [[NSNumber alloc] initWithInt:[maxHurdleHeight intValue] - [jumpValue intValue]];
    } else {
        return [[NSNumber alloc] initWithInt:0];
    }
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSString *stdout = [[[NSProcessInfo processInfo] environment] objectForKey:@"OUTPUT_PATH"];
        [[NSFileManager defaultManager] createFileAtPath:stdout contents:nil attributes:nil];
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:stdout];

        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

        NSData *availableInputData = [[NSFileHandle fileHandleWithStandardInput] availableData];
        NSString *availableInputString = [[NSString alloc] initWithData:availableInputData encoding:NSUTF8StringEncoding];
        NSArray *availableInputArray = [availableInputString componentsSeparatedByString:@"\n"];

        NSUInteger currentInputLine = 0;

        NSArray *nk = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSNumber *n = [nk[0] numberFromString:numberFormatter];

        NSNumber *k = [nk[1] numberFromString:numberFormatter];

        NSArray *heightTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *heightTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        [heightTemp enumerateObjectsUsingBlock:^(NSString *heightItem, NSUInteger idx, BOOL *stop) {
            [heightTempMutable addObject:[heightItem numberFromString:numberFormatter]];
        }];

        NSArray *height = [heightTempMutable copy];

        NSNumber *result = [[[Solution alloc] init] hurdleRace:k height:height];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

