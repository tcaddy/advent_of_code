#!/usr/bin/env ruby
class Solution
  WIDTH = 25
  HEIGHT = 6

  def call
    process
    layer = layer_with_fewest_zeros
    one_count(layer) * two_count(layer) # 1800 is too low
  end

  private

  def initialize(data)
    @data = data
    @layers = []
  end

  def process
    idx = 0
    while group = @data[idx * WIDTH * HEIGHT, WIDTH * HEIGHT] do
      if group.size == WIDTH * HEIGHT
        layer = []
        for row_idx in 0..(HEIGHT - 1)
          row = group[row_idx * WIDTH, WIDTH]
          layer << row.each_char.map(&:to_i) unless row.nil?
        end
        @layers << layer
      end
      idx += 1
    end
  end

  def layer_with_fewest_zeros
    @layers.sort do |x, y|
      zero_count(x) <=> zero_count(y)
    end.first
  end

  def zero_count(layer)
    n_count(layer, 0)
  end

  def one_count(layer)
    n_count(layer, 1)
  end

  def two_count(layer)
    n_count(layer, 2)
  end

  def n_count(layer, n)
    layer.map do |row|
      row.map { |pixel| pixel if pixel == n }
    end.flatten.compact.size
  end

end
if __FILE__ == $0
  puts Solution.new(File.open('data.csv', 'r').read).call
end