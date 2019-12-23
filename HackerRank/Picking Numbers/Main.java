import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;

class Result {

    /*
     * Complete the 'pickingNumbers' function below.
     *
     * The function is expected to return an INTEGER.
     * The function accepts INTEGER_ARRAY a as parameter.
     */

    public static int pickingNumbers(List<Integer> list) {
    // Write your code here
        Collections.sort(list);
        int listSize = list.size();
        int maxSubArrayLength = 0;
        int previousNumber = -1;
        for (int i = 0; i < listSize; i++) {
            int currentNumber = list.get(i);
            if (currentNumber == previousNumber) {
                continue;
            }
            previousNumber = i;
            int tempMaxSubArrayLength = 0;
            for (int j = i + 1; j < listSize; j++) {
                int difference = Math.abs(currentNumber - list.get(j));
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

}

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int n = Integer.parseInt(bufferedReader.readLine().trim());

        List<Integer> a = Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
            .map(Integer::parseInt)
            .collect(toList());

        int result = Result.pickingNumbers(a);

        bufferedWriter.write(String.valueOf(result));
        bufferedWriter.newLine();

        bufferedReader.close();
        bufferedWriter.close();
    }
}
