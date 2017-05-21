class Node
  include Enumerable
  
  attr_accessor :value, :parent, :left_child, :right_child
  
  def initialize(value)
    @value = value
    @parent = nil
    @left_child = nil
    @right_child = nil
  end
  
  def each(&block)
    @left_child.each(&block) if @left_child
    block.call(self)
    @right_child.each(&block) if @right_child
  end
  
  def add(child)
    child.parent = self
    
    if child.value <= @value
      if @left_child.nil?
        @left_child = child
      else
        @left_child.add(child)
      end
    else
      if @right_child.nil?
        @right_child = child
      else
        @right_child.add(child)
      end
    end
  end
end


def build_tree(arr, root = nil)
  copy = arr[0..-1]
  value = copy.delete_at(rand(arr.size))
  node = Node.new(value)
  
  return node if copy.empty?
   
  root ||= node
   
  root.add(build_tree(copy, root))
    
  node
end

def breadth_first_search(root, target)
  queue = [root]
  data = queue.shift
  
  until target == data.value
    queue << data.left_child unless data.left_child.nil?
    queue << data.right_child unless data.right_child.nil?
    
    return nil if queue.empty?
    data = queue.shift
  end
  
  data
end

def depth_first_search(root, target)
  last_visited = []
  stack = []
  data = root
  
  until target == data.value

    if data.left_child && !last_visited.include?(data.left_child)
      stack << data
      data = data.left_child 
    elsif data.right_child && !last_visited.include?(data.right_child)
      stack << data
      data = data.right_child
    else
      last_visited << data
      data = stack.pop     
    end

    return data if data.nil?
  end
  
  data
end

def dfs_rec(root, target) 
  return root if target == root.value
  
  left = dfs_rec(root.left_child, target) if root.left_child
  right = dfs_rec(root.right_child, target) if root.right_child
  
  left || right
end
