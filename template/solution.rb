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
    @data ||= File.open('./data.csv').read.split("\n")
  end

  def part_1; end

  def part_2; end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
