require 'csv'

f = File.read('sample.csv')
parsed = CSV.parse(f)
puts "Output from local file, 'sample.csv'"
puts "Full file: "
puts parsed
puts "Line 1"
puts parsed[0]
print "Line 1 -- First Node >>> "
puts parsed[0][0]
print "Line 2 -- First Node >>> "
puts parsed[1][0]
print "Line 3 -- Second Node >>> "
puts parsed[2][1]