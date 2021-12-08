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
    @data ||= File.open('./data.csv').read.split(',').map(&:to_i)
  end

  def part_1
    fuels = []
    data.min.upto(data.max) do |n1|
      fuel = 0
      data.each do |n2|
        fuel += (n1 - n2).abs
      end
      fuels << fuel
    end
    @results[:part_1] = fuels.min
  end

  def part_2
    fuels = []
    data.min.upto(data.max) do |n1|
      fuel = 0
      data.each do |n2|
        fuel += (n1 - n2).abs * ((n1 - n2).abs + 1)/2
      end
      fuels << fuel
    end
    @results[:part_2] = fuels.min
  end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
