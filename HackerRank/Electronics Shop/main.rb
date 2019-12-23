#!/bin/ruby

#
# Complete the getMoneySpent function below.
#
def getMoneySpent(keyboards, drives, budget)
    #
    # Write your code here.
    #
    highest_combination = -1
    keyboards.each do |keyboard|
        drives.each do |drive|
            sum = keyboard + drive
            highest_combination = sum if sum <= budget && sum > highest_combination
        end
    end
    highest_combination;
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

bnm = gets.rstrip.split

b = bnm[0].to_i

n = bnm[1].to_i

m = bnm[2].to_i

keyboards = gets.rstrip.split(' ').map(&:to_i)

drives = gets.rstrip.split(' ').map(&:to_i)

#
# The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
#

moneySpent = getMoneySpent keyboards, drives, b

fptr.write moneySpent
fptr.write "\n"

fptr.close()

