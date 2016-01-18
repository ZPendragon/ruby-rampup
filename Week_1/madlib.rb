puts ""
puts "-=-=-=-=- Mad Lib -=-=-=-=-"
print "Hi! I'm a bot! I tell stories with a little input! What's your name? "
user_input_name = gets.chomp
print "Hi #{user_input_name}, give me a noun: " 
user_input_noun = gets.chomp
user_input_noun.downcase!
print "Good one, give me one more: " 
user_input_nountwo = gets.chomp
user_input_nountwo.downcase!
print "So far so good, now give me a verb (ing):  " 
user_input_verb = gets.chomp
user_input_verb.downcase!
print "Great, finally give me an adjective: "
user_input_adj = gets.chomp
user_input_adj.downcase!
puts ""
puts ""
puts "		***** A Trip to the Doctor *****"
puts "								"
puts ""
puts "Thank you very much for seeing me, Doctor Who, and on such #{user_input_adj} notice."
puts ""
puts "What seems to be the problem, #{user_input_name}?"
puts ""
puts "I have a pain in my upper #{user_input_noun}, it hurts when I try #{user_input_verb}."
puts ""
puts "That doesn't sound normal, I would refrain from #{user_input_verb}."
puts ""
puts "Let's have a look at your #{user_input_noun}. OK I see it. I'm going to make a small incision..."
puts ""
puts "Wait, shouldn't you give me some #{user_input_noun} killer first!? Ow!!"
puts ""
puts "There! I fixed your #{user_input_noun} with my #{user_input_nountwo}."
puts ""
puts "Wow, I never would've thought #{user_input_nountwo} could fix my #{user_input_noun}!"
puts ""
puts "That's why I'm a doctor!"
puts ""
puts ""
puts "The End."
puts ""