require 'json'

class Solution

  def self.call(opts={})
    new(opts).call
  end

  def call
    part_1
    reset_position
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
    reset_position
    @results = { part_1: 0, part_2: 0 }
  end

  def reset_position
    @position = { depth: 0, horizontal: 0, aim: 0 }
  end

  def data
    @data ||= File.open('./data.csv').read.split("\n").map do |line|
      { action: line.split(' ')[0].to_sym, units: line.split(' ')[1].to_i }
    end
  end

  def part_1
    data.each do |item|
      case item[:action]
      when :forward then @position[:horizontal] += item[:units]
      when :up then @position[:depth] -= item[:units]
      when :down then @position[:depth] += item[:units]
      end
    end
    @results[:part_1] = @position[:depth] * @position[:horizontal]
  end

  def part_2
    data.each do |item|
      case item[:action]
      when :forward
        @position[:horizontal] += item[:units]
        @position[:depth] += item[:units] * @position[:aim]
      when :up then @position[:aim] -= item[:units]
      when :down then @position[:aim] += item[:units]
      end
    end
    @results[:part_2] = @position[:depth] * @position[:horizontal]
  end

end

puts Solution.call.to_json
