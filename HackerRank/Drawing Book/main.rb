#!/bin/ruby

#
# Complete the pageCount function below.
#
def pageCount(total_pages, goal_page)
    #
    # Write your code here.
    #
    half_of_the_book = (total_pages / 2).to_i
    total_swaps = 0
    if goal_page <= half_of_the_book
        i = 2
        while i <= goal_page
            total_swaps += 1 if i % 2 == 0
            i += 1
        end
    else
        i = total_pages - 1
        while i >= goal_page
            total_swaps += 1 unless i % 2 == 0
            i -= 1
        end
    end
    total_swaps
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

n = gets.to_i

p = gets.to_i

result = pageCount n, p

fptr.write result
fptr.write "\n"

fptr.close()
