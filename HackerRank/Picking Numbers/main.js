'use strict';

const fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', function(inputStdin) {
    inputString += inputStdin;
});

process.stdin.on('end', function() {
    inputString = inputString.split('\n');

    main();
});

function readLine() {
    return inputString[currentLine++];
}

/*
 * Complete the 'pickingNumbers' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts INTEGER_ARRAY a as parameter.
 */

function pickingNumbers(array) {
    // Write your code here
    array = array.sort();
    let arrayLength = array.length;
    let maxSubArrayLength = 0;
    let previousNumber = -1;
    for (let i = 0; i < arrayLength; i++) {
        let currentNumber = array[i]
        if (currentNumber === previousNumber) {
            continue;
        } 
        previousNumber = i;
        let tempMaxSubArrayLength = 0;
        for (let j = i + 1; j < arrayLength; j++) {
            let difference = Math.abs(currentNumber - array[j]);
            if (difference <= 1) {
                if (tempMaxSubArrayLength == 0) {
                    tempMaxSubArrayLength += 2;
                } else {
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
    return maxSubArrayLength;
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const n = parseInt(readLine().trim(), 10);

    const a = readLine().replace(/\s+$/g, '').split(' ').map(aTemp => parseInt(aTemp, 10));

    const result = pickingNumbers(a);

    ws.write(result + '\n');

    ws.end();
}
