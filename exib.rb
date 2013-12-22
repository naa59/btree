# encoding: UTF-8
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
        elsif action == "q"
                testtree=Btree::Tree.new
                keys=[]
                until keys.size>15 && testtree.root.size==1
                        keytoi=rand(50)
                        if testtree.insert(keytoi)
                                keys<<keytoi
                        end
                end
                vtree=testtree.visualize
                vtree.write_to_graphic_file('jpg')
                system( "mkdir -p ./graphs" )
                system( "rm -rf graph.dot" )
                system( "mv graph.jpg ./graphs/testgraph.jpg" )
                prim=testtree.root.keys[0]
                keys.delete(testtree.root.keys[0])
                testtree.delete(testtree.root.keys[0])
                vtree=testtree.visualize
                vtree.write_to_graphic_file('jpg')
                system( "mkdir -p ./graphs" )
                system( "rm -rf graph.dot" )
                system( "mv graph.jpg ./graphs/testgraph1.jpg" )
                answers=[]
                answers<<testtree.root.keys[0]
                keys.delete(testtree.root.keys[0])
                3.times do
                        ktoa=keys[rand(keys.size)]
                        keys.delete(ktoa)
                        answers<<ktoa
                end
                answers.shuffle!
                puts "Укажите первый ключ, который будет находиться в корне дерева с минимальной степенью 2 после удаления ключа #{prim}?\nЕсли правильных ответов несколько, то выберите наименьший."
                4.times do |i|
                        puts "#{i+1}) #{answers[i]}"
                end
                if answers[(gets.chomp.to_i)-1]==testtree.root.keys[0]
                        puts "Правильный ответ"
                else
                        puts "Неправильный ответ"
                end
        elsif action == "?"
                puts "'i' to Insert\n'd' to Delete\n's' to Search\n't' to Show the tree\n'q' to Test\n 'v' to Visualize the tree"
        else
                puts "Unknown action: '#{action}'\nTo see the list of actions input action '?'"
        end
end
