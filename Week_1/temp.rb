puts "-=-=-=-=- Temperature Converter -=-=-=-=-"
print "Hi! I'm a bot! Give me a temperature in (Farenheit) or (Celsius) for conversion!: "
temp_input = gets.chomp
puts ""
print "Convert to Farenheit 'F', or Celsius? 'C': " 
scale_input = gets.chomp
temp_input = temp_input.to_i
orig_temp = temp_input

if scale_input.include? "F"
    temp_input *= 1.8
	temp_input = temp_input + 32
	puts "Your temperature in Farenheit is " + temp_input.to_s + "."
	puts ""
	puts "Original temperature: #{orig_temp} C"
	puts ""
	puts "Coverted to #{scale_input}."
elsif scale_input.include? "C"
    temp_input = temp_input - 32
    temp_input /= 1.8
	puts ""
	puts "Your temperature in Celsius is " + temp_input.to_s + "."
	puts ""
	puts "Original temperature: #{orig_temp} F"
	puts ""
	puts "Coverted to #{scale_input}."
else
    print "Uh oh! Something went Wrong! Please try again."
end




