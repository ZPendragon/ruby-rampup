def null(input)
	abort("No input provided.") if input == ""
end

def ceasar(input, interval)
null(input)
null(interval)
input.downcase!
arr = input.split('')
alp = ('a'..'z').to_a

arr.map! { |i| alp.values_at(alp.index(i) + 1 + interval.to_i) }
puts arr.join
puts ""
puts "input: #{input}"
puts "interval: #{interval}"
end

puts "Give me a string to encrypt:"
string_input = gets.chomp
puts "How about an interval (i.e. 5):"
interval_input = gets.chomp

ceasar(string_input, interval_input)

