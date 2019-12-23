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

@interface NSString (ArrayFromString)
- (NSArray *) arrayFromString;
@end

@implementation NSString (ArrayFromString)
- (NSArray *) arrayFromString {
    return [self componentsSeparatedByString:@" "];
}
@end

@interface Solution:NSObject
- (NSNumber *) getMoneySpent:(NSArray *)keyboards drives:(NSArray *)drives budget:(NSNumber *)budget;
@end

@implementation Solution
/*
 * Complete the getMoneySpent function below.
 */
- (NSNumber *) getMoneySpent:(NSArray *)keyboards drives:(NSArray *)drives budget:(NSNumber *)budget {
    /*
     * Write your code here.
     */
    int highestCombination = -1;
    int totalBudget = [budget intValue];
    for (int i = 0; i < [keyboards count]; i++) {
        for (int j = 0; j < [drives count]; j++) {
            int sum = [keyboards[i] intValue] + [drives[j] intValue];
            if (sum <= totalBudget && sum > highestCombination) {
                highestCombination = sum;
            }
        }
    }
    return [[NSNumber alloc] initWithInt:highestCombination];
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

        NSArray *bnm = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSNumber *b = [bnm[0] numberFromString:numberFormatter];

        NSNumber *n = [bnm[1] numberFromString:numberFormatter];

        NSNumber *m = [bnm[2] numberFromString:numberFormatter];

        NSArray *keyboardsTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *keyboardsTempMutable = [NSMutableArray arrayWithCapacity:[n unsignedIntegerValue]];

        [keyboardsTemp enumerateObjectsUsingBlock:^(NSString *keyboardsItem, NSUInteger idx, BOOL *stop) {
            [keyboardsTempMutable addObject:[keyboardsItem numberFromString:numberFormatter]];
        }];

        NSArray *keyboards = [keyboardsTempMutable copy];

        NSArray *drivesTemp = [[availableInputArray objectAtIndex:currentInputLine] componentsSeparatedByString:@" "];
        currentInputLine += 1;

        NSMutableArray *drivesTempMutable = [NSMutableArray arrayWithCapacity:[m unsignedIntegerValue]];

        [drivesTemp enumerateObjectsUsingBlock:^(NSString *drivesItem, NSUInteger idx, BOOL *stop) {
            [drivesTempMutable addObject:[drivesItem numberFromString:numberFormatter]];
        }];

        NSArray *drives = [drivesTempMutable copy];

        /*
         * The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
         */

        NSNumber *moneySpent = [[[Solution alloc] init] getMoneySpent:keyboards drives:drives budget:b];

        [fileHandle writeData:[[moneySpent stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [fileHandle closeFile];
    }

    return 0;
}

