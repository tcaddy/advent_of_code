#!/usr/bin/env ruby
class Solution
  WIDTH = 25
  HEIGHT = 6
  COLORS = [ # by index
    :black,
    :white,
    :transparent
  ]
  PRINTABLE_COLORS = {
    white: '█',
    black: '░'
  }

  def call
    build_layers
    build_image
    print_image
    nil
  end

  private

  def initialize(data)
    @data = data
    @layers = []
    @image = []
  end

  def build_layers
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

  def build_image
    for x in 0..(WIDTH - 1)
      for y in 0..(HEIGHT - 1)
        @image[y] ||= []
        for layer_idx in 0..(@layers.size - 1)
          pixel = @layers[layer_idx][y][x]
          unless pixel == COLORS.index(:transparent)
            @image[y][x] = PRINTABLE_COLORS[COLORS[pixel]]
            break
          end
        end
      end
    end
  end

  def print_image
    @image.each_with_index do |row, idx|
      puts row.join('')
    end
  end

end
if __FILE__ == $0
  puts Solution.new(File.open('data.csv', 'r').read).call
end