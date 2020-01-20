#!/bin/ruby

require 'json'
require 'stringio'

# Complete the findDigits function below.
def findDigits(number)
  total_divisors = 0
  digits_array = number.to_s.split('')
  digits_array.each do |current_digit|
    current_digit = current_digit.to_i
    total_divisors += 1 if current_digit != 0 && number % current_digit == 0
  end
  total_divisors
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

t = gets.to_i

t.times do |t_itr|
    n = gets.to_i

    result = findDigits n

    fptr.write result
    fptr.write "\n"
end

fptr.close()

