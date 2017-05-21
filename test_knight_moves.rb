require './knight_moves'

def time
  start = Time.now
  yield
  Time.now - start
end


28.times do 
  p time { knight_moves([rand(0..7), rand(0..7)], [rand(0..7), rand(0..7)]) }
end
