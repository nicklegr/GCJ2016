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

def fit(map, dir, list)
  n = map.size
  list = list.split

  if map.flatten.all? {|e| !e }
    for i in 0...n
      map[0][i] = list[i]
    end
    return true
  end

ppd map
ppd list
ppd dir
  if dir == 0 # row
    for i in 0...n
      next if map[i][0] && list[0] != map[i][0]

      for j in 0...n
        return false unless !map[i][j] || map[i][j] == list[j]
      end

      for j in 0...n
        map[i][j] = list[j]
      end
ppd map
ppd "-----"
      return true
    end
    return false
  else # column
    for i in 0...n
      next if map[0][i] && list[0] != map[0][i]

      for j in 0...n
        return false unless !map[j][i] || map[j][i] == list[j]
      end

      for j in 0...n
        map[j][i] = list[j]
      end
ppd map
ppd "-----"

      return true
    end
    return false
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  lists = rws(2 * n - 1)
  lists.sort!

  answer = nil
  map = []
  for i in 0 ... (1 << (2 * n - 1))
    map = []
    n.times do
      map << [nil] * n
    end

    ok = true
    for j in 0 ... 2 * n - 1
      fit = false
      dir = (i >> j) & 1
      if !fit(map, dir, lists[j])
        ok = false
        break
      end
    end
    next unless ok

# ppd map
    next if map.flatten.any? {|e| !e }

    map_lists = []
    for i in 0...n
      map_lists << map[i].join(" ")
      col = map[i][0]
      for j in 1...n
        col += " " + map[i][j]
      end
      map_lists << col
    end
pp map_lists
pp lists
    lists.each do |e|
      i = map_lists.index(e)
      raise if !i
      map_lists.delete_at(i)
    end
    raise if map_lists.size >= 2
    answer = map_lists.first
    break
  end

pp answer
  # answer.uniq!
  raise if answer.size != 1

  puts "Case ##{case_index}: #{answer.first}"

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
