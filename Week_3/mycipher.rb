def encrypt()
	puts "What is your secret message?"
	secret_input = gets.chomp
	secret_input.delete! " "
	puts "How about an interval (i.e. 5):"
	interval_input = gets.chomp
	interval_input.delete " "
	#caesar_encrypt(secret_input, interval_input)
	route(secret_input)
end

def decrypt()
	puts "What is your encrypted message?"
	secret_input = gets.chomp
	puts "How about an interval (i.e. 5):"
	interval_input = gets.chomp
	caesar_decrypt(secret_input, interval_input)
end

def null(input)
	abort("No input provided.") if input == ""
end

def caesar_encrypt(input, interval)
null(input)
null(interval)
input.downcase!
arr = input.split('')
alp = ('a'..'z').to_a

	arr.map! do |i| 
		node = alp.index(i) + interval.to_i
		if node > alp.count
			node = node - alp.count
		end
		alp.values_at(node)
	 end
	puts arr.join
	#route(arr.join)
end

def caesar_decrypt(input, interval)
null(input)
null(interval)
input.downcase!
arr = input.split('')
alp = ('a'..'z').to_a

	arr.map! do |i| 
		node = alp.index(i) - interval.to_i
		if node > alp.count
			node = node + alp.count
		end
		alp.values_at(node)
	 end
	puts arr.join
	#route(arr.join)
end

def route(input)
	arr = input.split('')
	# Split grid into 3 arrays 
	#example: "theyfoundyou"
	#should be [t,f,d]
	# 		   [h,o,y]
	# 		   [e,u,o]
	# 		   [y,n,u]
	line_count = arr.count / 4
	encrypted = []
	remain = arr.count % 4
	#puts line_count
	0.upto(line_count) { |num| (num..arr.length-1).step(4).each { |i| encrypted.push(arr[i]) } }

	#1.downto(remain) { |num| line_one.insert((num * 4) - 1, arr[-num]) }
	# ["t", "f", "d",     "h", "o", "y",        "e", "u", "o", "y", "n", "u"]

	#bug: # of iterations through the range needs to be at least the length of the array or
		  # we wont return the values expected
		  # 12 chars works because the range 0..11 1..11 2..11 3..11 == 3 steps * 4 each
	puts encrypted.join
	puts ""
end

encrypt()
#decrypt()