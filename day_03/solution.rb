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
    @results = {
      part_1: { gamma: nil, epsilon: nil, consumption: nil },
      part_2: { o: nil, co2: nil }
    }
    @max_position = data.first.to_s.length - 1
  end

  def reset_position
    @position = { depth: 0, horizontal: 0, aim: 0 }
  end

  def data
    @data ||= File.open('./data.csv').read.split("\n")
  end

  def part_1
    parts = { gamma: [], epsilon: [] }
    0.upto(@max_position) do |position|
      case most_common_value(position: position)
      when 0
        parts[:gamma] << 0
        parts[:epsilon] << 1
      when 1
        parts[:gamma] << 1
        parts[:epsilon] << 0
      else
        raise 'we should not be here!'
      end
    end
    @results[:part_1][:gamma] = parts[:gamma].join('').to_i(2)
    @results[:part_1][:epsilon] = parts[:epsilon].join('').to_i(2)
    @results[:part_1][:consumption] = \
      @results[:part_1][:gamma] * @results[:part_1][:epsilon]
  end

  def part_2
    part_2_oxygen(alt_data: data, initial_position: 0)
    part_2_co2(alt_data: data, initial_position: 0)
    @results[:part_2][:life_support] = \
      @results[:part_2][:o] * @results[:part_2][:co2]
  end

  def part_2_oxygen(alt_data:, initial_position:)
    initial_position.upto(@max_position) do |position|
      mcv = most_common_value(position: position, alt_data: alt_data)
      vals = \
        numbers_matching(val: mcv || 1, alt_data: alt_data, position: position)
      if vals.size == 1
        @results[:part_2][:o] = vals.first.to_s.to_i(2)
        return
      end

      return part_2_oxygen(alt_data: vals, initial_position: position + 1)
    end
  end

  def part_2_co2(alt_data:, initial_position:)
    initial_position.upto(@max_position) do |position|
      lcv = least_common_value(position: position, alt_data: alt_data)
      vals = \
        numbers_matching(val: lcv || 0, alt_data: alt_data, position: position)
      if vals.size == 1
        @results[:part_2][:co2] = vals.first.to_s.to_i(2)
        return
      end

      return part_2_co2(alt_data: vals, initial_position: position + 1)
    end
  end

  def most_common_value(position:, alt_data: nil)
    cnts = counts(position: position, alt_data: alt_data)
    return nil if cnts[0] == cnts[1]

    cnts[0] > cnts[1] ? 0 : 1
  end

  def least_common_value(position:, alt_data: nil)
    cnts = counts(position: position, alt_data: alt_data)
    return nil if cnts[0] == cnts[1]

    cnts[0] > cnts[1] ? 1 : 0
  end

  def counts(position:, alt_data: nil)
    counts = [0, 0]
    (alt_data || data).each do |line|
      item = line[position, 1]
      counts[item.to_i] += 1
    end
    counts
  end

  def numbers_matching(val:, alt_data:, position:)
    alt_data.select do |item|
      item[position, 1].to_i == val
    end
  end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
