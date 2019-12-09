#import <Foundation/Foundation.h>

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

@interface Solution:NSObject
- (NSNumber *) pageCount:(NSNumber *)n p:(NSNumber *)p;
@end

@implementation Solution
/*
 * Complete the pageCount function below.
 */
- (NSNumber *) pageCount:(NSNumber *)n p:(NSNumber *)p {
    /*
     * Write your code here.
     */
    int totalPages = [n intValue];
    int goalPage = [p intValue];
    int halfOfTheBook = totalPages / 2;
    int totalSwaps = 0;
    if (goalPage <= halfOfTheBook) {
        for(int i = 2; i <= goalPage; i++) {
            if (i % 2 == 0) {
                totalSwaps++;
            }
        }
    } else {
        for(int i = totalPages - 1; i >= goalPage; i--) {
            if (i % 2 != 0) {
                totalSwaps++;
            }
        }
    }
    return [[NSNumber alloc] initWithInt:totalSwaps];
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

        NSNumber *n = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
        currentInputLine += 1;

        NSNumber *p = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
        currentInputLine += 1;

        NSNumber *result = [[[Solution alloc] init] pageCount:n p:p];

        [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}
