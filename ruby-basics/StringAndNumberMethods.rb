

string_variable = "Teste de String";

puts "String Methods"
puts ""

puts "Normal: " + string_variable;
puts "UpCase: " + string_variable.upcase();
puts "DownCase: " + string_variable.downcase();
puts "Capitalize: " + string_variable.capitalize();
puts "Swap: " + string_variable.swapcase();

puts "---------------------------";

puts "Access By Index: " + string_variable[1].to_s;
puts "Include: " + string_variable.include?("teste").to_s;
puts "Find By Index: " + string_variable.index("S").to_s;
puts "Matchs: " + string_variable.match("Teste").to_s;

puts "---------------------------";

puts "Length: " + string_variable.length().to_s;
puts "Empty: " + string_variable.empty?.to_s;

puts "---------------------------";

puts "Reverse: " + string_variable.reverse();
puts "Split: " + string_variable.split().to_s;
puts "Slice: " + string_variable.slice(0, 5);

puts ""

puts "Number Methods"
puts ""
number_variable = -1.2345

puts "Round: " + number_variable.round().to_s;
puts "Floor: " + number_variable.floor().to_s;
puts "Ceil: " + number_variable.ceil().to_s;
puts "Absolute: " + number_variable.abs().to_s;

puts "---------------------------";

puts "Integer: " + number_variable.integer?.to_s;
puts "Negative: " + number_variable.negative?().to_s;
puts "Positive: " + number_variable.positive?().to_s;
puts "Zero: " + number_variable.zero?().to_s;

