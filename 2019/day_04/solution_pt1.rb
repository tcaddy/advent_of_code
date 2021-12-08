#!/usr/bin/env ruby
class Solution
  LOW = 272091
  HIGH = 815432

  attr_accessor :n

  def call
    return nil unless check_for_six_digits?
    return nil unless in_range?
    return nil unless adjacent_digits?
    return nil unless increasing?
    true
  end

  private

  def initialize(n)
    @n = n
  end

  def check_for_six_digits?
    n.to_s.size == 6
  end

  def in_range?
    n >= LOW && n <= HIGH
  end

  def adjacent_digits?
    last = nil
    "#{n}".each_char do |digit|
      return true if digit == last
      last = digit
    end
    false
  end

  def increasing?
    last = 0
    "#{n}".each_char do |n|
      return false unless n.to_i >= last
      last = n.to_i
    end
    true
  end

end
if __FILE__ == $0
  puts (((Solution::LOW..Solution::HIGH).map do |n|
    Solution.new(n).call
  end).compact.size)
end