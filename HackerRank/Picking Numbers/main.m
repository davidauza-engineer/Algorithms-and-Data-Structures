#import <Foundation/Foundation.h>
#import <objc/Object.h>
#import <objc/objc.h>

@interface NSString (StringByTrimmingTrailingCharactersInSet)
- (NSString *) stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
@end

@implementation NSString (StringByTrimmingTrailingCharactersInSet)
- (NSString *) stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange end = [self rangeOfCharacterFromSet:[characterSet invertedSet] options:NSBackwardsSearch];

    if (end.location == NSNotFound) {
        return @"";
    }

    return [self substringToIndex:end.location + 1];
}
@end

@interface NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter;
@end

@implementation NSString (NumberFromString)
- (NSNumber *) numberFromString:(NSNumberFormatter *)formatter {
    NSNumber *number = [formatter numberFromString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

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
    return [[self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@" "];
}
@end

@interface Solution:NSObject
- (NSNumber *) pickingNumbers:(NSArray *)array;
@end

@implementation Solution
/*
 * Complete the 'pickingNumbers' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts INTEGER_ARRAY a as parameter.
 */

- (NSNumber *) pickingNumbers:(NSArray *)array {
    // Write your code here
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    int arrayLength = [array count];
    int maxSubArrayLength = 0;
    int previousNumber = -1;
    for (int i = 0; i < arrayLength; i++) {
        int currentNumber = [array[i] intValue];
        if (currentNumber == previousNumber) {
            continue;
        }
        previousNumber = i;
        int tempMaxSubArrayLength = 0;
        for (int j = i + 1; j < arrayLength; j++) {
            int difference = abs(currentNumber - [array[j] intValue]);
            if (difference <= 1) {
                if (tempMaxSubArrayLength == 0) {
                    tempMaxSubArrayLength += 2;
                } else  {
                    tempMaxSubArrayLength++;
                }
            } else {
                break;
            }
        }
        if (tempMaxSubArrayLength > maxSubArrayLength) {
            maxSubArrayLength = tempMaxSubArrayLength;
        }
    }
    return [[NSNumber alloc] initWithInt:maxSubArrayLength];
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

        NSNumber *n = [[[availableInputArray objectAtIndex:currentInputLine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] numberFromString:numberFormatter];
        currentInputLine += 1;

        NSArray *aTemp = [[[availableInputArray objectAtIndex:currentInputLine] stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *aTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        for (NSString *aItem in aTemp) {
            [aTempMutable addObject:[aItem numberFromString:numberFormatter]];
        }

        NSArray *a = [aTempMutable copy];

        NSNumber *result = [[[Solution alloc] init] pickingNumbers:a];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

