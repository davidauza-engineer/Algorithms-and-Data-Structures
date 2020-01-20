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

@interface Solution:NSObject
- (NSNumber *) findDigits:(NSNumber *)number;
@end

@implementation Solution
// Complete the findDigits function below.
- (NSNumber *) findDigits:(NSNumber *)number {
    int totalDivisors = 0;
    int intNumber = [number intValue];
    NSString *numberString = [number stringValue];
    for (int i = 0; i < numberString.length; i++) {
        // 48 is subtracted due to the method characterAtIndex returns an unichar
        int currentDigit = [numberString characterAtIndex:i] - 48;
        if ((currentDigit != 0) && ((intNumber % currentDigit) == 0)) {
            totalDivisors++;
        }
    }
    return [[NSNumber alloc] initWithInt:totalDivisors];
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

        NSNumber *t = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
        currentInputLine += 1;

        for (NSUInteger tItr = 0; tItr < [t integerValue]; tItr++) {
            NSNumber *n = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
            currentInputLine += 1;

            NSNumber *result = [[[Solution alloc] init] findDigits:n];

            [fileHandle writeData:[[result stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }

        [fileHandle closeFile];
    }

    return 0;
}

