import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.regex.*;

public class Main {

    // Complete the findDigits function below.
    static int findDigits(int number) {
        int totalDivisors = 0;
        String numberString = Integer.toString(number);
        char[] digitsArray = numberString.toCharArray();
        for (int i = 0; i < digitsArray.length; i++) {
            int currentDigit = Character.getNumericValue(digitsArray[i]);
            if ((currentDigit != 0) && ((number % currentDigit) == 0)) {
                totalDivisors++;
            }
        }
        return totalDivisors;
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int t = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

        for (int tItr = 0; tItr < t; tItr++) {
            int n = scanner.nextInt();
            scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

            int result = findDigits(n);

            bufferedWriter.write(String.valueOf(result));
            bufferedWriter.newLine();
        }

        bufferedWriter.close();

        scanner.close();
    }
}
