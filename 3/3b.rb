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
  attr_reader :nonoverlapping_claim_ids

  def initialize
    @grid = {}
    @nonoverlapping_claim_ids = []
  end

  def add_claim(fabric_claim)
    @nonoverlapping_claim_ids << fabric_claim.id

    fabric_claim.occupied_squares.each do |coord|
      if @grid[coord]
        @grid[coord] << fabric_claim.id
        @nonoverlapping_claim_ids.delete_if { |id| @grid[coord].include? id }
      else
        @grid[coord] = [fabric_claim.id]
      end
    end
  end
end


claim_tracker = ClaimTracker.new

File.readlines('input.txt').each do |line|
  claim_tracker.add_claim FabricClaim.new(line)
end

puts "nonoverlapping claims: #{claim_tracker.nonoverlapping_claim_ids}"