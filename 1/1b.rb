require 'set'

input = File.readlines('1a_input.txt').map(&:to_i)

seen_frequencies = SortedSet.new
current_freq = 0
i = 0

loop do
  current_freq += input[i]
  break if seen_frequencies.include? current_freq
  seen_frequencies.add current_freq
  i = input[i + 1] ? i + 1 : 0
end

puts "First repeated frequency is #{current_freq}"