#!/usr/bin/env ruby
class Solution

  def call
    restore_state
    calculate
    @arr[0]
  end

  private

  def initialize(arr)
    @arr = arr.map(&:to_i)
    @idx = 0
  end

  def restore_state
    @arr[1] = 12
    @arr[2] = 2
  end

  def opcode
    @arr[@idx]
  end

  def val1
    @arr[@arr[@idx + 1]]
  end

  def val2
    @arr[@arr[@idx + 2]]
  end

  def result_idx
    @arr[@idx + 3]
  end

  def result
    case opcode
    when 1 then val1 + val2
    when 2 then val1 * val2
    else raise "Unknown opcode: #{opcode}"
    end
  end

  def calculate
    return if opcode == 99
    @arr[result_idx] = result
    @idx += 4
    if opcode
      return calculate
    end
  end

end
if __FILE__ == $0
  puts Solution.new(File.open('data.csv', 'r').read.split(',')).call
end
