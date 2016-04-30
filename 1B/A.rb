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

SUBS = [["SIX", 6],
 ["TWO", 2],
 ["ZERO", 0],
 ["EIGHT", 8],
 ["THREE", 3],
 ["FOUR", 4],
 ["FIVE", 5],
 ["ONE", 1],
 ["NINE", 9],
 ["SEVEN", 7],
 ]

(1 .. cases).each do |case_index|
  str = rs
  ans = ""

  SUBS.each do |sub, index|
ppd str
    ok = true
    sub.each_char do |e|
      if !str.include?(e)
        ok = false
      end
    end

    if ok
      loop do
        old = str.dup
        sub.each_char do |e|
          str.sub!(e, "")
        end
# ppd str
# ppd index.to_s
        if old.size == str.size + sub.size
          ans += index.to_s
        else
          str = old
          break
        end
      end
    end
  end

ppd str
  raise if str != ""

  s = ans.each_char.to_a.sort.join("")
  puts "Case ##{case_index}: #{s}"

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
