require 'set'

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
    xs, ys = @left_edge.upto(@right_edge).to_a, @top_edge.upto(@bottom_edge).to_a
    xs.product(ys).map { |x, y| "(#{x},#{y})".to_sym }
  end
end

class ClaimTracker
  attr_reader :nonoverlapping_claim_ids

  def initialize
    @grid = {}
    @nonoverlapping_claim_ids = SortedSet.new
  end

  def add_claim(fabric_claim)
    @nonoverlapping_claim_ids << fabric_claim.id

    fabric_claim.occupied_squares.each do |coord|
      if @grid[coord]
        ids = @grid[coord] << fabric_claim.id
        ids.each { |id| @nonoverlapping_claim_ids.delete(id) }
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

puts "nonoverlapping claims: #{claim_tracker.nonoverlapping_claim_ids.to_a}"