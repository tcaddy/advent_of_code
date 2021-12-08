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
    @data ||= File.open('./data.csv').read.split(',').compact.map(&:to_i)
  end

  def part_1
    initialize_state
    1.upto(80) do |day|
      process_day
    end
    @results[:part_1] = @state.sum
  end

  def part_2
    initialize_state
    1.upto(256) do |day|
      process_day
    end
    @results[:part_2] = @state.sum
  end

  def initialize_state
    @state = Array.new(9, 0)
    data.each do |fish|
      @state[fish] += 1
    end
  end

  def process_day
    new_state = Array.new(9, 0)
    to_add = 0
    @state.each_with_index do |cnt, idx|
      if idx.zero?
        to_add += cnt
        next
      end

      new_state[idx - 1] = cnt
    end
    new_state[6] += to_add
    new_state[8] += to_add
    @state = new_state
    # new_fish_count = 0
    # @state.each_with_index do |fish, idx|
    #   @state[idx] = fish.zero? ? 6 : (fish - 1)
    #   new_fish_count += 1 if fish.zero?
    # end
    # @state += Array.new(new_fish_count, 8)
    # zero_count = @state.count('0')
    # @state.gsub!('0', '|')
    # @state.gsub!('1', '0')
    # @state.gsub!('2', '1')
    # @state.gsub!('3', '2')
    # @state.gsub!('4', '3')
    # @state.gsub!('5', '4')
    # @state.gsub!('6', '5')
    # @state.gsub!('7', '6')
    # @state.gsub!('8', '7')
    # @state.gsub!('|', '6')
    # @state += '8' * zero_count
  end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
