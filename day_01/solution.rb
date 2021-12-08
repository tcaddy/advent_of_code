require 'json'

class Solution

  def self.call(opts={})
    new(opts).call
  end

  def call
    part_1
    part_2
    @results
  rescue => e
    require 'pry'
    binding.pry
    raise e
  end

  private

  def initialize(opts={})
    @opts = opts
    @results = { part_1: 0, part_2: 0 }
  end

  def data
    @data ||= File.open('./data.csv').read.split("\n").map(&:to_i)
  end

  def part_1
    # start at index one instead of zero b/c index zero has no previous value
    # to which to compare
    1.upto(data.size - 1) do |idx|
      @results[:part_1] += 1 if data[idx] > data[idx - 1]
    end
  end

  def part_2
    # start at index two instead of zero b/c that's the first index position
    # that has 3 previous values to use for summing that we can use for
    # comparing the previous sum
    3.upto(data.size - 1) do |idx|
      @results[:part_2] +=1 if data[idx-2..idx].sum > data[idx-3..idx-1].sum
    end
  end

end

puts Solution.call.to_json
