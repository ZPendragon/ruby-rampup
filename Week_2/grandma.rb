#Write a Deaf Grandma program. Whatever you say to grandma(user input) 
#she should respond with HUH?!, SPEAK UP SONNY!, unless you shout it(type in all CAPS). 
#If you shout, she can hear you and yells back NO, NOT SINCE 1938! 
#Grandma should shout a different year each time; random between 1930 to 1980. 
#You can’t stop talking to grandma until you shout BYE.

#Add on to the above. Grandma really loves your company and doesn’t want you to go unless 
#you shout BYE three times in a row. So if you say BYE twice and then something else 
#you have to say BYE three times again.

puts "BILLY?!, COME HERE BILLY!"
print "Grandma, my name is "
user_input = gets.chomp
all_caps = user_input.upcase!
puts "WHAT! AT LEAST YOU KNOW I'M STILL BREATHING..."
puts "DID YOU SAY SOMETHING BILLY?"
user_input = gets.chomp
all_caps = user_input.upcase
bye_count = 0
while bye_count !=3
	if user_input != "BYE"
		if user_input == user_input.upcase
			bye_count = 0	
			rand_year = rand(1930..1938)
			puts "NO, NOT SINCE #{rand_year}!"
		else 
			puts "HUH?!, SPEAK UP SONNY!"
			bye_count = 0	
		end
	elsif user_input == "BYE"
		bye_count += 1
		puts "Did you say bye?!"
		if bye_count == 2
			puts "Are you sure? Who's gonna play bingo with grandma!"
		elsif bye_count == 3
			puts "Ok, bye bye now."
		end
	end
	if bye_count != 3
	user_input = gets.chomp
	all_caps = user_input.upcase
	end
end
