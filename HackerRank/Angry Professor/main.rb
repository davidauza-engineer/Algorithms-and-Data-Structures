#!/bin/ruby

require 'json'
require 'stringio'

# Complete the angryProfessor function below.
def angryProfessor(minimum_students, arrivals_array)
  students_on_time = arrivals_array.count { |arrival| arrival <= 0 }
  students_on_time < minimum_students ? "YES" : "NO"
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

t = gets.to_i

t.times do |t_itr|
    nk = gets.rstrip.split

    n = nk[0].to_i

    k = nk[1].to_i

    a = gets.rstrip.split(' ').map(&:to_i)

    result = angryProfessor k, a

    fptr.write result
    fptr.write "\n"
end

fptr.close()

