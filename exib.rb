$LOAD_PATH << './lib'
require 'btree.rb'

puts "Input minimal degree(default: 2):"
degree = gets.chomp.to_i
grnum=1
if !degree || degree<2
	puts "Invalid degree: #{degree}. Using degree: 2 instead" 
	tree=Btree::Tree.new
	else
	tree=Btree::Tree.new(degree)
end
puts "To see the list of actions input action '?'"
while true
	puts "Input action" 
	action=gets.chomp.to_s
	if action == "i"
		puts "Input key to insert:"
		key=gets.chomp.to_i
		tree.insert(key)
	elsif action == "d"
		puts "Input key to delete:"
		key=gets.chomp.to_i
		tree.delete(key)
	elsif action == "s"
		puts "Input key to search for:"
		key=gets.chomp.to_i
		puts tree.search(key).inspect
	elsif action == "t"
		puts
		tree.show
		puts
	elsif action == "v"
		vtree=tree.visualize
		vtree.write_to_graphic_file('jpg')
		system( "mkdir -p ./graphs" )
		system( "rm -rf graph.dot" )
		system( "mv graph.jpg ./graphs/graph#{grnum}.jpg" )
		puts "Created graph#{grnum}.jpg file\n"
		grnum+=1
	elsif action == "?"
		puts "'i' to Insert\n'd' to Delete\n's' to Search\n't' to Show the tree\n'v' to Visualize the tree"
	else
		puts "Unknown action: '#{action}'\nTo see the list of actions input action '?'"
	end
end
