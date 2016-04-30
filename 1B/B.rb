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
QUES = 9999

(1 .. cases).each do |case_index|
  c, j = rss

  len = c.size
  rc = /#{c.gsub("?", '\d')}/
  rj = /#{j.gsub("?", '\d')}/
putsd rc, rj

  cs = []
  c.each_char do |e|
    if e == "?"
      cs << QUES
    else
      cs << e.to_i
    end
  end

  js = []
  j.each_char do |e|
    if e == "?"
      js << QUES
    else
      js << e.to_i
    end
  end

  cand = []
  max = 10 ** len
  for i_c in 0...max
    for i_j in 0...max
      ok = true
      for k in 0...len
        if cs[k] != QUES
          ok &= ((i_c / (10 ** k)) % 10) == cs[k]
        end
        if js[k] != QUES
          ok &= ((i_j / (10 ** k)) % 10) == js[k]
        end
      end

      if ok
        cand << [(i_c - i_j).abs, i_c, i_j]
      end
    end
  end

  ans = cand.sort.first

  puts "Case ##{case_index}: #{sprintf("%0#{len}d", ans[1])} #{sprintf("%0#{len}d", ans[2])}"

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
