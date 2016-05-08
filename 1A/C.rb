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

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  fs = ris.map do |e| e-1 end

  mem = (0...n).to_a
ppd mem
ppd fs
  answer = nil
  for i in 3..n
    mem.permutation(i) do |circle|
      ok = true
      for j in 0...i
        cur = j
        prv = j == 0 ? i-1 : j-1
        nex = (j+1) % i
        me = circle[cur]
        unless fs[me] == circle[prv] || fs[me] == circle[nex]
          ok = false
          break
        end
      end
      if ok
        answer = i
        break
      end
    end
  end

  puts "Case ##{case_index}: #{answer}"

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
