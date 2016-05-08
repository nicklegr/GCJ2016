i = 1

ARGF.readlines.each do |e|
  e.gsub!(/Case #\d+/, "Case ##{i}")
  puts e
  i += 1
end
