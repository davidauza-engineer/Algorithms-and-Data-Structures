'use strict';

const fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', inputStdin => {
    inputString += inputStdin;
});

process.stdin.on('end', _ => {
    inputString = inputString.trim().split('\n').map(str => str.trim());

    main();
});

function readLine() {
    return inputString[currentLine++];
}

/*
 * Complete the pageCount function below.
 */
function pageCount(totalPages, goalPage) {
    /*
     * Write your code here.
     */
    let halfOfTheBook = Math.floor(totalPages / 2);
    let totalSwaps = 0;
    if (goalPage <= halfOfTheBook) {
        for(let i = 2; i <= goalPage; i++) {
            if (i % 2 === 0) {
                totalSwaps++;
            }
        }
    } else {
        for(let i = totalPages - 1; i >= goalPage; i--) {
            if (i % 2 !== 0) {
                totalSwaps++;
            }
        }
    }
    return totalSwaps;
}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const n = parseInt(readLine(), 10);

    const p = parseInt(readLine(), 10);

    let result = pageCount(n, p);

    ws.write(result + "\n");

    ws.end();
}
