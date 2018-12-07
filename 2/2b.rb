def single_char_diff?(str_1, str_2)
  seen_diff_char = false

  str_1.chars.zip(str_2.chars).each do |c1, c2|
    if c1 != c2
      if seen_diff_char
      	return false 
      else
      	seen_diff_char = true
      end
    end
  end
  true
end

def common_chars_str(str_1, str_2)
  str_2_chars = str_2.chars

  str_1.chars
  	.select.with_index { |c, i| c == str_2_chars[i] }
  	.join
end

File.readlines('input.txt').combination(2).each do |box_id_1, box_id_2|
  if single_char_diff?(box_id_1, box_id_2)
    puts "The common letters are: " + common_chars_str(box_id_1, box_id_2)
    break
  end
end
