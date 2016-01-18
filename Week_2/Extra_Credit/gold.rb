# Init values
GOLD_OUNCE = 1336.0

def price_of_gold(ounces)
	total_price = ounces * GOLD_OUNCE
	total_price = (total_price).round(2)
	puts "The price of gold for #{ounces} ounces is $#{total_price}"
end

def price_of_gold_from_pounds(pounds)
	#Conv
	if pounds == "" || pounds <= 0
		puts "Value entered: #{pounds}, not an acceptable value."
	else
		puts "       ****Gold Price in Pound(s)**** "
		total_ounces = pounds * 16
		price_of_gold(total_ounces)
	end
end

def price_of_gold_from_kilograms(kilograms)
	#convert to pounds, then ounces
	if kilograms == "" || kilograms <= 0
		puts "Value entered: #{kilograms}, not an acceptable value."
	else
	puts "       ****Gold Price in Kilogram(s)**** "
	total_ounces = (kilograms * 2.2) * 16.0
	price_of_gold(total_ounces)
	end
end

puts "Hi! I'm a bot. I return the price of gold in kilos or pounds"
print "Please enter a gold amount in (pounds): "
user_input_pounds = gets.chomp.to_f
print "Please enter a gold amount in (kilograms): "
user_input_kilograms = gets.chomp.to_f
puts ""
puts ""
price_of_gold_from_pounds(user_input_pounds)
puts ""
price_of_gold_from_kilograms(user_input_kilograms)