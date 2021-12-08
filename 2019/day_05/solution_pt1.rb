#!/usr/bin/env ruby
class Solution
  attr_accessor :arr

  def call
  end

  private

  def initialize(data)
    @arr = data.split(',').map(&:to_i)
  end

end
if __FILE__ == $0
  puts Solution.new(File.open('data.csv', 'r').read).call
end