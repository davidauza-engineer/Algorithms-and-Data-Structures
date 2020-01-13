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
- (NSString *) angryProfessor:(NSNumber *)minimumStudents a:(NSArray *)a;
@end

@implementation Solution
// Complete the angryProfessor function below.
- (NSString *) angryProfessor:(NSNumber *)minimumStudents a:(NSArray *)arrivalsArray {
    int studentsOnTime = 0;
    for (NSNumber *arrival in arrivalsArray) {
        if ([arrival intValue] <= 0) {
            studentsOnTime++;
        }
    }
    if (studentsOnTime < [minimumStudents intValue]) {
        return @"YES";
    } else {
        return @"NO";
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

        NSNumber *t = [[availableInputArray objectAtIndex:currentInputLine] numberFromString:numberFormatter];
        currentInputLine += 1;

        for (NSUInteger tItr = 0; tItr < [t integerValue]; tItr++) {
            NSArray *nk = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
            currentInputLine += 1;

            NSNumber *n = [nk[0] numberFromString:numberFormatter];

            NSNumber *k = [nk[1] numberFromString:numberFormatter];

            NSArray *aTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
            currentInputLine += 1;

            NSMutableArray *aTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

            [aTemp enumerateObjectsUsingBlock:^(NSString *aItem, NSUInteger idx, BOOL *stop) {
                [aTempMutable addObject:[aItem numberFromString:numberFormatter]];
            }];

            NSArray *a = [aTempMutable copy];

            NSString *result = [[[Solution alloc] init] angryProfessor:k a:a];

            [fileHandle writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }

        [fileHandle closeFile];
    }

    return 0;
}

