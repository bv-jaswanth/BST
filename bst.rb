class TreeNode
    attr_accessor :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end

class BST
    attr_accessor :root, :size
    def initialize()
        @root = nil
        @size = 0;
    end


    def insert(value)
        if @root == nil
            @root = TreeNode.new(value)
        else
            curr_node = @root
            prev_node = @root

            while curr_node != nil
                prev_node = curr_node
                if value < curr_node.value
                    curr_node = curr_node.left
                else
                    curr_node = curr_node.right
                end # while loop end
            end
            if value < prev_node.value
                prev_node.left = TreeNode.new(value)
            else
                prev_node.right = TreeNode.new(value)
            end
        end  # main if_else end
    end # insert method end


    def in_order(node = self.root)
        if node == nil
            return
        end
        in_order(node.left)
        print " #{node.value},"
        in_order(node.right)
    end # in_order method end

    def post_order(node = self.root)
        if node == nil
            return
        end
        post_order(node.left)
        post_order(node.right)
        print " #{node.value},"
    end # post_order method end

    def pre_order(node = self.root)
        if node == nil
            return
        end
        print " #{node.value},"
        pre_order(node.left)
        pre_order(node.right)
    end #pre_order method end

    def min(node = self.root)
        if node == nil
            return
        elsif node.left == nil
            print "#{node.value}"
            return
        end
        return min(node.left)
    end # min method end

    def max(node = self.root)
        if node == nil
            return
        elsif node.right == nil
            print "#{node.value}"
            return
        end
        return max(node.right)
    end # max method end

    def search(value, node = self.root)
        if node == nil
            print "Number not found"
            return
        elsif node.value > value
            search(value, node.left)
        elsif node.value < value
            search(value, node.right)
        else
            print "Number found"
        end
    end # search method end

    def remove(node = self.root, value)
        if node == nil
            return
        
        elsif node.value == value
            case
                when node.right == nil
                then return node.left
                    
                when node.right !=nil
                then
                    pointer = node.right
                    
                    while pointer.left != nil
                        pointer = pointer.left
                    end
                    node.value = pointer.value
                    node.right = remove(node.right,pointer.value)
                    return node
                end # case end
        else
            node.left = remove(node.left, value)
            node.right = remove(node.right, value)
            return node
        end # if_else end
    end

    def paths(node = self.root)
        array = []
        all_paths(node, array)
    end # paths method end

    def all_paths(node = self.root, array)
        if node == nil
            return
        end
        array << node.value
        if node.left == nil && node.right == nil
            puts "\n"
            l = array.length
            array.each_with_index do |n, id|
                break if id == l-1
                print "#{n} -> "
            end
            print "#{array[l-1]}"
        end
        all_paths(node.left, array)
        all_paths(node.right, array)
        array.pop
    end # all_paths method end

end # BST method end

tree = BST.new
## Input to the array can be taken in 3 methods

# array = [8, 5, 3, 7, 10, 12, 9] # Direct input to the array

# puts "Enter the elements of the array: " # Taking input from the end user on the console
# array = gets.chomp
# array = array.split()
# i = 0
# for arg in array
#    array[i] = arg.to_i
#    i = i+1
# end 

array = ARGV # taking input in the command line along while starting the script
i = 0
for arg in array
   array[i] = arg.to_i
   i = i+1
end
array.each { |n| tree.insert(n) }
num = 0
print "********************Binary search Tree********************\n"
print "----------------------------Menu--------------------------\n"
print "0.Menu\n1.Pre order traversal\n2.Post order traversal\n3.In order traversal\n4.Minimum number of the BST"
print "\n5.Maximum number of the BST\n6.Search number\n7.Delete node\n8.Print All paths of the BST\n9.Quit"
while num>=0
	print "\nEnter your choice: "
	num = STDIN.gets.chomp.to_i # Here we had to use STDIN so that gets captures only strings otherwise we'll get an error when we use ARGV to pass arguments 
	num = num .to_i
	case num
	when 0
		print "1.Pre order traversal\n2.Post order traversal\n3.In order traversal\n4.Minimum number and Maximum number of the BST"
		print "\n5.Search number\n6.Insert number\n7.Delete node\n8.Print All paths of the BST\n9.Quit"
	when 1
		print "\nPre Order traversal of the BST: "
		tree.pre_order
	when 2
		print "\nPost Order traversal of the BST: "
		tree.post_order
	when 3
		print "\nIn Order traversal of the BST: "
		tree.in_order
	when 4
		print "\nMinimum number of the BST: "
		tree.min
		print "\nMaximum number of the BST: "
		tree.max
	when 5
		print "\nEnter the number to be searched: "
		s = STDIN.gets.chomp.to_i
		tree.search(s)	
    when 6
        print "\nEnter the number to be inserted: "
        i = STDIN.gets.chomp.to_i
        tree.insert(i)
	when 7
		print "\nEnter the node to be deleted: "
		r = STDIN.gets.chomp.to_i
		tree.remove(r)
		print "#{r} is deleted"
	when 8
		print "\nAll paths from root to leaf in the BST: "
		tree.paths
	when 9
        file = File.open("users.txt", "w") 
        for x in array
            file.puts(x)
        end
        print "\nThe elements are saved in a file"
		print "\n************************Thank you************************"
		num = -1
	end # case end
end # while end

