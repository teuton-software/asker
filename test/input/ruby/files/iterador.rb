
names = ['obi-wan', 'yoda', 'darth vader']

names.each do |i|
  if i[0,5] == 'darth'
    puts "Bye #{i.upcase}!"
  else
    puts "Hello #{i.capitalize}!"
  end
end
