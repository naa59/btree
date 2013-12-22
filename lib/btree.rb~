require 'rgl/adjacency'
require 'rgl/dot'

class Btree

        class Tree

        attr_reader :root, :degree

        def initialize(degree = 2)
                @degree = degree
                @root = Btree::Node.new(@degree)
                @root.leaf = true
        end

        def insert(key)
                if search(key)
                        return nil
                else
                        r=@root
                        if r.full?
                                s=Btree::Node.new(@degree)
                                @root=s
                                s.leaf=false
                                s.children << r
                                s.split(0)
                                s.insert(key)
                        else
                                r.insert(key)
                        end
                end
        end
        
        def show
                @root.show
        end
        
        def search(key,node = root)
                i=1
                while i<=node.size && key > node.keys[i-1]
                        i+=1
                end
                if i<=node.size && key == node.keys[i-1]
                        return node
                elsif
                        node.leaf?
                                return nil
                else
                        return self.search(key,node.children[i-1])
                end
        end
        
        def delete(key)
                if !search(key)
                        return nil
                else
                        @root.delete(key)
                end
        end

        def visualize
                if @root.size<=0
                        return nil
                else
                        @root.visualize
                end        
        end

        def degree
                @degree
        end

        def root
                @root
        end
        
        end

        class Node

        attr_accessor :leaf

        def initialize(degree)
                    @degree = degree
                    @keys = []
                    @children = []
                    @leaf = true
          end
        
        def show
                childrenarray=[]
                puts "#{keys}"
                print "("
                children.each do |c|
                        print "#{c.keys}"
                        childrenarray << c
                end
                print ")\n"
                show_helper(childrenarray)
        end
        
        def insert(key)
                i=size-1
                if leaf?
                        while i>=0 && @keys[i] && key < @keys[i]
                                i-=1
                        end
                        @keys.insert(i+1,key)
                else
                        while i>=0 && @keys[i] && key < @keys[i]
                                i-=1
                        end
                        if @children[i+1].full?
                                split(i+1)
                                 if key > @keys[i+1]
                                        i+=1
                                end
                        end
                @children[i+1].insert(key)
                end
                        
        end
                
        def split(index)
                ktrack=[]
                ctrack=[]
                child=@children[index]
                new_node=Btree::Node.new(@degree)
                new_node.leaf=child.leaf
                (@degree-1).times do |j|
                        new_node.keys[j]=child.keys[j+@degree]
                        ktrack << child.keys[j+@degree]
                end
                if !child.leaf?
                        @degree.times do |j|
                                new_node.children[j]=child.children[j+@degree]
                                ctrack << child.children[j+@degree]
                        end
                end
                (@keys.size).downto(index) do |j|
                        @children[j+1]=@children[j]
                end
                @children[index+1]=new_node
                (@keys.size - 1).downto(index) do |j|
                        @keys[j+1]=@keys[j]
                end
                @keys[index]=child.keys[@degree-1]
                child.keys.delete_at(@degree-1)
                ktrack.each do |j|
                        child.keys.delete(j)
                end
                ctrack.each do |j|
                        child.children.delete(j)
                end
        end
        
        def delete(key)
                i=0
                while i<size && key > keys[i]
                        i+=1
                end
                if i<=size && key == keys[i]
                        if leaf?
                                return keys.delete(key)
                        elsif children[i].size>=@degree
                                        keys[i]=children[i].fbig
                                        return children[i].delete(children[i].fbig)
                        elsif children[i+1].size>=@degree
                                        keys[i]=children[i+1].fsmall
                                        return children[i+1].delete(children[i+1].fsmall)
                        else                 
                                        children[i].keys << key
                                        (@degree-1).times do |j|
                                                children[i].keys << children[i+1].keys[j]
                                        end
                                        children[i+1].children.size.times do |j|
                                                children[i].children << children[i+1].children[j]
                                        end
                                        keys.delete(key)
                                        if @keys.empty?
                                                @degree=children[i].degree
                                                @leaf=children[i].leaf?
                                                @keys=children[i].keys
                                                @children=children[i].children
                                                return delete(key)
                                        else
                                                children.delete_at(i+1)
                                                return children[i].delete(key)
                                        end
                        end
                end
                if leaf?
                        return nil
                end
                if children[i].size<@degree
                        if children[i-1] && i!=0 && children[i-1].size>=@degree                                
                                children[i].keys.unshift(keys[i-1])
                                keys[i-1]=children[i-1].keys[-1]
                                children[i-1].keys.delete_at(-1)
                                if children[i-1].children[-1]
                                        children[i].children.unshift(children[i-1].children[-1])
                                        children[i-1].children.delete_at(-1)
                                end
                                return children[i].delete(key)
                        elsif children[i+1] && children[i+1].size>=@degree
                                children[i].keys << (keys[i])
                                keys[i]=children[i+1].keys[0]
                                children[i+1].keys.delete_at(0)
                                if children[i+1].children[0]
                                        children[i].children << children[i+1].children[0]
                                        children[i+1].children.delete_at(0)
                                end
                                return children[i].delete(key)
                        elsif children[i-1] && i!=0
                                children[i].keys.size.times do |j|
                                        children[i-1].keys << (children[i].keys[j])
                                end
                                if children[i].children.size>0
                                        children[i].children.size.times do |j|
                                                children[i-1].children << (children[i].children[j])
                                        end
                                end
                                children[i-1].keys.insert(@degree-1,keys[i-1])
                                children.delete_at(i)
                                keys.delete_at(i-1)
                                if @keys.empty?
                                        @degree=children[i-1].degree
                                        @leaf=children[i-1].leaf?
                                        @keys=children[i-1].keys
                                        @children=children[i-1].children
                                        return delete(key)
                                else

                                        return children[i-1].delete(key)
                                end
                        elsif children[i+1]
                                children[i+1].keys.size.times do |j|
                                        children[i].keys << children[i+1].keys[j]
                                end
                                if children[i+1].children.size>0
                                children[i+1].children.size.times do |j|
                                        children[i].children << children[i+1].children[j]
                                end
                                end
                                children[i].keys.insert(@degree-1,keys[i])
                                children.delete_at(i+1)
                                keys.delete_at(i)
                                if @keys.empty?
                                        @degree=children[i].degree
                                        @leaf=children[i].leaf?
                                        @keys=children[i].keys
                                        @children=children[i].children
                                        return delete(key)
                                else
                                        return children[i].delete(key)
                                end
                        end
                end
                return children[i].delete(key)
        end

        def visualize
                childrenarray=[]
                vtree=RGL::DirectedAdjacencyGraph.new
                if leaf?
                        vtree.add_vertex(keys.to_s.slice(1..-2))
                        return vtree
                else
                children.each do |c|
                        vtree.add_edge(keys.to_s.slice(1..-2),c.keys.to_s.slice(1..-2))
                        childrenarray << c
                end
                end
                return vishelper(vtree,childrenarray)
        end

        def leaf?
                @leaf
        end

        def children
                @children
        end

        def keys
                @keys
        end
        
        def degree
                @degree
        end

        def size
                    @keys.size
          end

        def full?
                    size >= 2 * @degree - 1
          end

        def fsmall
                if leaf?
                        return keys[0]
                else
                        return children[0].fsmall
                end
        end

        def fbig
                if leaf?
                        return keys[-1]
                else
                        return children[-1].fbig
                end
        end

        end

end

def generate_btree(keys=10,degree=2,limit=20)
        tree=Btree::Tree.new(degree)
                keys.times do
                        tree.insert(rand(limit))
                end
        return tree
end

def show_helper(array)
        if array[0] && !array[0].leaf?
                temp=[]
                array.each do |c|
                        print "("
                                c.children.each do |cc|
                                        print "#{cc.keys}"
                                        temp << cc
                                end
                        print ")"
                end
                puts
                return show_helper(temp)
        end
end

def vishelper(tree,array)
        if array[0] && !array[0].leaf?
                temp=[]
                array.each do |c|
                        c.children.each do |cc|
                                tree.add_edge(c.keys.to_s.slice(1..-2),cc.keys.to_s.slice(1..-2))
                                temp << cc
                        end
                end
                return vishelper(tree,temp)
        else
                return tree
        end
end
