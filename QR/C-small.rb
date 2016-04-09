require 'pp'
require 'prime'

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

def base_n(v, base)
  ret = 0
  d = 1
  while v != 0
    ret += (v & 1) * d
    v >>= 1
    d *= base
  end
  ret
end

# for i in 2..10
#   ppd base_n(0b1001, i)
# end
# exit

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  puts "Case ##{case_index}:"

  n, j = ris

  coin = ((1 << (n-1)) | 1)

  count = 0
  loop do
    raise if coin >= (1 << n)
    break if count == j

    # ppd coin.to_s(2)

    divisors = []

    ok = true
    for base in 2..10
      factors = base_n(coin, base).prime_division(Prime::EratosthenesGenerator.new)
      if factors.size == 1
        ok = false
        break
      end
      divisors << factors[0][0]
    end

    if ok
      puts "#{coin.to_s(2)} #{divisors.join(" ")}"
      count += 1
    end

    coin += 2
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
