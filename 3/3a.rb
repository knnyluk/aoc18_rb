class FabricClaim
  attr_reader :id

  def initialize(claim_str)
    captures = claim_str.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).captures.map(&:to_i)
    @id = captures[0]
    @left_edge = captures[1] + 1
    @top_edge = captures[2] + 1
    @right_edge = captures[1] + captures[3]
    @bottom_edge = captures[2] + captures[4]
  end

  def occupied_squares
    squares = []
    (@left_edge..@right_edge).each do |x_coord|
      (@top_edge..@bottom_edge).each do |y_coord|
        squares << "#{x_coord}x#{y_coord}".to_sym
      end
    end
    squares
  end
end

class ClaimTracker

  def initialize
    @grid = {}
  end

  def add_claim(fabric_claim)
    fabric_claim.occupied_squares.each do |coord|
      if @grid[coord]
        @grid[coord] << fabric_claim.id
      else
        @grid[coord] = [fabric_claim.id]
      end
    end
  end

  def overlapped_squares_count
    count = 0
    @grid.values.each { |claims_per_square| count += 1 if claims_per_square.size >= 2 }
    count
  end
end


claim_tracker = ClaimTracker.new

File.readlines('input.txt').each do |line|
  claim_tracker.add_claim(FabricClaim.new(line))
end

puts "#{claim_tracker.overlapped_squares_count} squares overlap"