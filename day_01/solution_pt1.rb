#!/usr/bin/env ruby
class Solution

  def call
    calculate
  end

  private

  def initialize(val)
    @val = val
  end

  def calculate
    (@val / 3.0).floor - 2
  end

end
if __FILE__ == $0
  puts (File.open('data.csv', 'r').read.split("\n").map do |line|
    Solution.new(line.to_i).call
  end).sum
end
