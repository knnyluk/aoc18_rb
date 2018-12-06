class BoxId < String

  def initialize(box_id_str)
  	@box_id = box_id_str
    @two_count_chars = []
    @three_count_chars = []
  end

  def count_letters
  	@box_id.chars.each_with_object(Hash.new(0)) do |char, counts| 
  	  counts[char] += 1
  	  case counts[char]
  	  when 2
  	  	@two_count_chars << char
  	  when 3
  	  	@two_count_chars.delete char
  	  	@three_count_chars << char
  	  when 4
  	  	@three_count_chars.delete char
  	  end
  	end
  end

  def has_two_count_char?
  	not @two_count_chars.empty?
  end

  def has_three_count_char?
  	not @three_count_chars.empty?
  end
end

two_count = 0 
three_count = 0

File.readlines('input.txt').each do |box_id_str|
  box_id = BoxId.new(box_id_str)
  box_id.count_letters
  two_count += 1 if box_id.has_two_count_char?
  three_count += 1 if box_id.has_three_count_char?
end

puts "checksum is #{two_count * three_count}"