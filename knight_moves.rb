class Board
  attr_accessor :hash_map
  
  def initialize
    @hash_map = Array.new(8) { Array.new(8, ["  "]) }
  end      
end


class Knight
  include Enumerable

  attr_accessor :position, :parent, :children
  
  def initialize(position)
    @position = position
    @parent = nil
    @children = []
  end
  
  def each
    data = @parent
    
    until data.nil?
      yield data
      data = data.parent
    end
  end   
  
  def move(board)
    alts = [-2, -1, 1, 2].permutation(2).select { |a, b| a.abs != b.abs }

    board.hash_map.each_with_index do |row, row_idx|
      row.each_with_index do |cell, cell_idx|
        if alts.include?([(@position[0] - row_idx), (@position[1] - cell_idx)])
          @children << [row_idx, cell_idx]                
        end
      end
    end
    self
  end

  def to_s
    puts "You made it in #{self.count} moves! Here's your path:"
    self.reverse_each { |knight| p knight.position }
    p self.position
  end    
end


def knight_moves(start, finish)
  board = Board.new
  knight = Knight.new(start)

  queue = [knight]
  
  until knight.position == finish
    knight = queue.shift
    
    knight.move(board).children.each do |child|
      node = Knight.new(child)
      node.parent = knight
      queue << node
    end
  end
  
  knight.to_s
end
