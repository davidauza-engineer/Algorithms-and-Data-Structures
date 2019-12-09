import java.io.*;
import java.math.*;
import java.text.*;
import java.util.*;
import java.util.regex.*;

public class Main {

    /*
     * Complete the pageCount function below.
     */
    static int pageCount(int totalPages, int goalPage) {
        /*
         * Write your code here.
         */
        int halfOfTheBook = totalPages / 2;
        int totalSwaps = 0;
        if (goalPage <= halfOfTheBook) {
            for (int i = 2; i <= goalPage; i++) {
                if (i % 2 == 0) {
                    totalSwaps++;
                }
            }
        } else {
            for (int i = totalPages - 1; i >= goalPage; i--) {
                if (i % 2 != 0) {
                    totalSwaps++;
                }
            }
        }
        return totalSwaps;
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int n = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])*");

        int p = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])*");

        int result = pageCount(n, p);

        bufferedWriter.write(String.valueOf(result));
        bufferedWriter.newLine();

        bufferedWriter.close();

        scanner.close();
    }
}
