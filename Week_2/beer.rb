beer_count = 99
while beer_count > 1 
	puts "#{beer_count} bottles of beer on the wall, #{beer_count} bottles of beer!"
	print "Take one down, pass it around, "
	beer_count -= 1
	puts "#{beer_count} bottles of beer on the wall"
	puts ""
end
puts "No more bottles of beer on the wall, no more bottles of beer."
beer_count = 99
puts "Go to the store and buy some more, #{beer_count} bottles of beer on the wall..."