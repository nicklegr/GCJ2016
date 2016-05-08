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

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  ps = ris
ppd ps

  chars = ("A".."Z").to_a

  ans = []
  count = ps.inject(:+)
  while count != 0
    not_zero = ps.select{|e| e != 0}
    not_zero_index = []
    ps.each_with_index do |e, i|
      if e != 0
        not_zero_index << i
      end
    end

    if not_zero.size == 2
      if not_zero[0] == not_zero[1]
        ans << "#{chars[not_zero_index[0]]}#{chars[not_zero_index[1]]}"
        ps[not_zero_index[0]] -= 1
        ps[not_zero_index[1]] -= 1
        count -= 2
        next
      end
    end

    if count == 2
      s = ""
      for i in 0...ps.size
        if ps[i] != 0
          s += chars[i]
        end
      end
      ans << s
      break
    else
      raise if count == 1

      max = -1
      max_i = nil
      for i in 0...ps.size
        if max < ps[i]
          max = ps[i]
          max_i = i
        end
      end

      raise if max == -1 || !max_i

      ans << chars[max_i]
      ps[max_i] -= 1
      count -= 1
    end

    # check
ppd ps
    total = ps.inject(:+)
    ps.each do |e|
      raise if e.to_f / total > 0.5
    end
  end

  puts "Case ##{case_index}: #{ans.join(" ")}"

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
