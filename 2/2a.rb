class BoxId

  def initialize(box_id_str)
    @two_count_chars = []
    @three_count_chars = []
    count_letters(box_id_str)
  end

  def has_two_count_char?
  	not @two_count_chars.empty?
  end

  def has_three_count_char?
  	not @three_count_chars.empty?
  end

  private

  def count_letters(str)
    str.chars.each_with_object(Hash.new(0)) do |char, counts| 
      counts[char] += 1
      case counts[char]
      when 2
        @two_count_chars << char
      when 3
        @three_count_chars << @two_count_chars.delete(char)
      when 4
        @three_count_chars.delete char
      end
    end
  end
end

two_count = 0 
three_count = 0

File.readlines('input.txt').each do |box_id_str|
  box_id = BoxId.new(box_id_str)
  two_count += 1 if box_id.has_two_count_char?
  three_count += 1 if box_id.has_three_count_char?
end

puts "checksum is #{two_count * three_count}"