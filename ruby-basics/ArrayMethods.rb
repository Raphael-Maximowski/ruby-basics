
array_empty = Array.new

puts "Insert Items: "

array_empty.push(1)
array_empty.insert(1, 2, 3, 4 , 5, 6)
array_empty << 7
array_empty.unshift(0)
array_empty.insert(0, nil, nil, nil)

puts array_empty

puts ""

puts("Remove Itens: ")
array_empty.pop()
array_empty.delete(6)
array_empty.delete_at(5)
array_empty.compact!

puts array_empty
puts ""

puts("Search Itens: ")
puts "First By Index: " + array_empty[0].to_s
puts "First: " + array_empty.first().to_s
puts "Last: " + array_empty.last().to_s
puts "Take: " + array_empty.take(2).to_s
puts "Drop: " + array_empty.drop(2).to_s

array_empty.reverse!
puts "Sort: " + array_empty.sort().to_s
puts "Length: " + array_empty.length().to_s
puts "Find Index: " + array_empty.index(0).to_s


