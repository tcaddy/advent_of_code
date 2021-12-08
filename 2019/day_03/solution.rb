#!/usr/bin/env ruby
class Solution

  def call
    
  end

  private

  def initialize(arr)
    @wire1 = arr[0]
    @wire2 = arr[1]
  end

end
if __FILE__ == $0
  puts Solution.new(
    File.open('data.csv', 'r').read.split("\n").map{|line| line.split(',') }
  ).call
end