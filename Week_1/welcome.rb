puts "-=-=-=-=- Welcome -=-=-=-=-"
print "Hi! I'm a bot! What's your name? "
user_input = gets.chomp
puts ""
print "Pleased to meet you #{user_input}, how old are you? " 
age_input = gets.chomp
age_input = age_input.to_s
puts ""
puts "Ok, your name is #{user_input} and you are #{age_input} years old."