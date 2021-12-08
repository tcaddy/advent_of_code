#!/usr/bin/env ruby
class Solution
  DELIMITER = ')'.freeze

  def call
    tld_com = com
    # map_orbits
    # @orbit_count[:direct] + @orbit_count[:indirect]
  end

  private

  def initialize(data)
    @orbits = data.split("\n")
    @orbit_count = { direct: 0, indirect: 0}
    @map = {}
    @keys = []
    @indirect_orbits = {}
    @com = nil
  end

  def com
    return @com if @com
    centers, orbiters = [], []
    @orbits.each do |orbit|
      centers << orbit.split(DELIMITER)[0]
      orbiters << orbit.split(DELIMITER)[1]
    end
    @com = centers.uniq - orbiters.uniq
  end

  def map_orbits
    @map[com] ||= {}
    @orbits.find_all do |orbit|
      orbit.split(DELIMITER)[0] == com
    end.each do |direct|
      @orbit_count[:direct] += 1
      @com = direct.split(DELIMITER)[1]
      map_orbits
    end
  end

  def map_indirect_orbits
    @indirect_orbits.keys.each do |key|

    end
  end

end
if __FILE__ == $0
  puts Solution.new(File.open('data.csv', 'r').read).call
end