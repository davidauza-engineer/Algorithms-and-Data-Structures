#!/bin/ruby

require 'json'
require 'stringio'

#
# Complete the 'pickingNumbers' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY a as parameter.
#

def pickingNumbers(array)
    # Write your code here
    array.sort!
    array_length = array.length
    max_sub_array_length = 0
    previous_number = -1
    i = 0
    while i < array_length
        current_number = array[i]
        if current_number == previous_number
            i += 1
            next
        end
        previous_number = i
        temp_max_sub_array_length = 0
        j = i + 1
        while (j < array_length)
            difference = (current_number - array[j]).abs
            if difference <= 1
                temp_max_sub_array_length += 1 if temp_max_sub_array_length == 0
                temp_max_sub_array_length += 1
            else
                j += 1
                next;
            end
            j += 1
        end
        max_sub_array_length = temp_max_sub_array_length if temp_max_sub_array_length > max_sub_array_length
        i += 1
    end
    max_sub_array_length
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

n = gets.strip.to_i

a = gets.rstrip.split.map(&:to_i)

result = pickingNumbers a

fptr.write result
fptr.write "\n"

fptr.close()

