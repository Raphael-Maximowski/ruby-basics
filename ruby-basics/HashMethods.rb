empty_hash = Hash.new()

filled_hash = {
    :key1 => true,
    :key2 => 2,
    :key3 =>  "Teste"
}

puts "Filled Hash: "
puts filled_hash

puts ""

puts "Empty Hash: "
puts(empty_hash[:false_key])

empty_hash[:first_key] = {
    :second_key => 'Test'
}
puts(empty_hash[:first_key][:second_key])

puts ""
puts "Object Methods: "
puts "Keys" + empty_hash.keys().to_s
puts "Values" + empty_hash.values().to_s
puts "Size: " + empty_hash.size().to_s
puts "Empty: " + empty_hash.empty?.to_s

empty_hash.delete(:first_key)

puts "Empty: " + empty_hash.empty?.to_s