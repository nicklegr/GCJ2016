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

def popcount(n)
  n = (n & 0x55555555) + (n >> 1 & 0x55555555);
  n = (n & 0x33333333) + (n >> 2 & 0x33333333);
  n = (n & 0x0f0f0f0f) + (n >> 4 & 0x0f0f0f0f);
  n = (n & 0x00ff00ff) + (n >> 8 & 0x00ff00ff);
  return (n & 0x0000ffff) + (n >>16 & 0x0000ffff);
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  words = rws(n)
  words.map! do |e|
    e.split
  end

ppd words

  # 0: real 1: fake
  max_fake = 0
  for i in 0...(1 << n)
    real_0 = {}
    real_1 = {}

    for j in 0...n
      if (i & (1 << j)) == 0
        real_0[words[j][0]] = 1
        real_1[words[j][1]] = 1
      end
    end

ppd "pattern: #{i}"
ppd real_0
ppd real_1

    ok = true
    for j in 0...n
      if (i & (1 << j)) != 0
ppd words[j][0]
ppd words[j][1]

        ok &= (real_0[words[j][0]] && real_1[words[j][1]])
      end
    end
ppd ok

    if ok
      fakes = popcount(i)
ppd fakes
      if max_fake < fakes
        max_fake = fakes
      end
    end
ppd "--------"
  end

  puts "Case ##{case_index}: #{max_fake}"

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
