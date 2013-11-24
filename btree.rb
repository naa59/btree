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
	
	def search(key,node = root)
		i=1
		while i<=node.size && key > node.keys[i-1]
			i+=1
		end
		if  i<=node.size && key == node.keys[i-1]
			return node
		elsif
			node.leaf?
				return nil
		else
			return self.search(key,node.children[i-1])
		end
	end
	
	def delete(key)
		@root.delete(key)
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

	end

end
