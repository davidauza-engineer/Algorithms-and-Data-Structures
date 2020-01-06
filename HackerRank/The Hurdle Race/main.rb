#!/bin/ruby

require 'json'
require 'stringio'

# Complete the hurdleRace function below.
def hurdleRace(jump_height, heights_array)
  max_hurdle_height = heights_array.max
  return max_hurdle_height - jump_height if jump_height < max_hurdle_height
  0
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

nk = gets.rstrip.split

n = nk[0].to_i

k = nk[1].to_i

height = gets.rstrip.split(' ').map(&:to_i)

result = hurdleRace k, height

fptr.write result
fptr.write "\n"

fptr.close()

