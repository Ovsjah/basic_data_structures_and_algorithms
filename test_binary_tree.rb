require './binary_tree'

def time
  start = Time.now
  yield
  Time.now - start
end

arr = 14.times.map { rand(0..1000) }
root = build_tree(arr)

build_tree_time = time { p build_tree(arr) }
puts "--------------------------------"
puts ">> build tree => #{build_tree_time} sec\n\n"

bfs_time = time do
  arr.each { |value| p breadth_first_search(root, value) }
end
puts "------------------------------------------"
puts ">> breadth first search => #{bfs_time} sec\n\n"

dfs_time = time do
  arr.each { |value| p depth_first_search(root, value) }
end
puts "----------------------------------------"
puts ">> depth first search => #{dfs_time} sec\n\n"


dfs_rec_time = time do
  arr.each { |value| p dfs_rec(root, value) }
end
puts "--------------------------------------------------"
puts ">> recursive depth first search => #{dfs_rec_time} sec\n\n"
