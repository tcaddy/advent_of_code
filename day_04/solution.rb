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
    define_boards
  end

  def data
    @data ||= File.open('./data.csv').read.split("\n")
  end

  def drawn_numbers
    data.first.split(',').map(&:to_i)
  end

  def define_boards
    return @boards if defined?(@boards)

    @boards = []
    board = nil
    data.each_with_index do |line, idx|
      next if idx.zero?

      if line == ''
        @boards << board if board
        board = []
        next
      end

      board << line.gsub(/\s{2,}/, ' ').split(' ').map(&:to_i)
    end
    @boards
  end

  def part_1
    winner = find_winner
    @results[:part_1] = score_board(board: winner[:board]) * winner[:val]
  end

  def find_winner
    drawn_numbers.each_with_index do |val, idx|
      mark_boards(val: val)
      board = check_for_winner
      return { board: board, val: val } if board
    end
    nil
  end

  def part_2
    while @boards.size > 0 do
      winner = find_winner
      remove_board(board: winner[:board])
    end
    @results[:part_2] = score_board(board: winner[:board]) * winner[:val]
  end

  def mark_boards(val:)
    @boards = @boards.map do |board|
      board.map do |row|
        row.map do |item|
          item == val ? 'X' : item
        end
      end
    end
  end

  def check_for_winner
    @boards.each_with_index do |board, idx|
      return board if board.include?(%w[X X X X X])
      return board if vertical_match?(board: board)
    end
    nil
  end

  def vertical_match?(board:)
    0.upto(4) do |idx|
      col = board.map {|row| row[idx] }

      return true if board.map {|row| row[idx] } == %w[X X X X X]
    end
    false
  end

  def score_board(board:)
    board.flatten.select { |item| item != 'X' }.sum
  end

  def board_to_s(board:)
    board.map {|row| row.join("\t") }.join("\n")
  end

  def remove_board(board:)
    @boards = @boards.select {|b| b != board }
  end

end

puts Solution.call.to_json if File.expand_path(__FILE__) == File.expand_path($0)
