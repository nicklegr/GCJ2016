require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def parr(arr)
  puts arr.join(" ")
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

$ans = nil

def p_mat(mat)
  str = mat.map do |e| e.to_s(2) end
  puts str.join(" ")
end

def count(mat, b, i)
  if i == b
    return 1
  end

  total = 0
  for j in 0...b-1
    if ((mat[i] >> j) & 1) == 1
      total += count(mat, b, j)
    end
  end
  total
end

def solve(mat, cur, b, m)
p_mat(mat)
  if $ans
    return
  end

  if mat.size == b - 1
    if count(mat, b, 0) == m
      $ans = mat
      return
    end
    return
  end

  i = mat.size
  mask = (1 << b) - 1
  mask &= ~(1 << i)
  for j in 0...i
    if ((mat[j] >> i) & 1) != 0
      mask &= ~(1 << j)
    end
  end

  # for all subsets
  y = mask
  if y == 0
    mat << y
    solve(mat, cur | y, b, m)
    mat.pop
  else
    while y > 0
      mat << y
      solve(mat, cur | y, b, m)
      mat.pop

      y -= 1
      y &= mask
    end
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # x = 202;  
  
  # # for (int y = x; y > 0; --y &= x)  
  # #     cout << bitset<8>(y) << endl;  
  # puts "#{x.to_s(2)}:"

  # y = x
  # while y > 0
  #   puts y.to_s(2)

  #   y -= 1
  #   y &= x
  # end

  b, m = ris

  $ans = nil
  mat = []
  cur = 0
  solve(mat, cur, b, m)

  if $ans
    puts "Case ##{case_index}: POSSIBLE"
    $ans.each do |e|
      puts e.to_s(2)
    end
  else
    puts "Case ##{case_index}: IMPOSSIBLE"
  end

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
