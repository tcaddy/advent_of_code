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
    @data ||= File.open('./data.csv').read.split("\n").map do |line|
      line.split(' -> ').map do |point|
        point.split(',').map(&:to_i)
      end
    end
  end

  def part_1
    initialize_diagram
    data.each do |points|
      # points is an Array: [ [x1, y1], [x2, y2] ]
      next unless horizontal_or_vertical?(points: points)

      add_line_to_diagram(points: points)
    end
    @results[:part_1] = overlapping_count
  end

  def part_2
    initialize_diagram
    data.each do |points|
      add_line_to_diagram(points: points)
    end
    @results[:part_2] = overlapping_count
  end

  def horizontal_or_vertical?(points:)
    horizontal?(points: points) || vertical?(points: points)
  end

  def horizontal?(points:)
    # [ [1, 1], [5, 1] ]
    points[0][1] == points[1][1]
  end

  def vertical?(points:)
    # [ [1, 1], [1, 5] ]
    points[0][0] == points[1][0]
  end

  def bounds
    return @bounds if defined?(@bounds)

    @bounds = { x: { hi: 0, lo: 0}, y: { hi: 0, lo: 0} }
    data.each do |points|
      point1 = points[0]
      point2 = points[1]
      if [point1[0], point2[0]].max > @bounds[:x][:hi]
        @bounds[:x][:hi] = [point1[0], point2[0]].max
      end
      if [point1[1], point2[1]].max > @bounds[:y][:hi]
        @bounds[:y][:hi] = [point1[1], point2[1]].max
      end
    end
    @bounds
  end

  def initialize_diagram
    @diagram = []
    bounds[:x][:lo].upto(bounds[:x][:hi] + 1) do |x|
      row = []
      bounds[:y][:lo].upto(bounds[:y][:hi] + 1) do |y|
        row << 0
      end
      @diagram << row
    end
  end

  def add_line_to_diagram(points:)
    if horizontal?(points: points)
      y = points[0][1]
      xs = [ points[0][0], points[1][0] ]
      xs.min.upto(xs.max) do |x|
        @diagram[y][x] += 1
      end
    elsif vertical?(points: points)
      x = points[0][0]
      ys = [ points[0][1], points[1][1] ]
      ys.min.upto(ys.max) do |y|
        @diagram[y][x] += 1
      end
    else
      x1, y1 = points[0]
      x2, y2 = points[1]
      xs = \
        if x1 > x2
          (x2..x1).to_a.reverse
        else
          (x1..x2).to_a
        end
      ys = \
        if y1 > y2
          (y2..y1).to_a.reverse
        else
          (y1..y2).to_a
        end
      xs.each_with_index do |x, idx|
        y = ys[idx]
        @diagram[y][x] += 1
      end
    end
  end

  def diagram_to_s
    @diagram.map do |row|
      row.join(" ").gsub('0', '.')
    end.join("\n")
  end

  def overlapping_count
    @diagram.flatten.select{|n| n >= 2}.count
  end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
