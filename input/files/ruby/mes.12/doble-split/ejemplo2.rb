#!/usr/bin/ruby

vector = []
vector << { :dirname => 'private', :perm => '700' }
vector << { :dirname => 'gruop', :perm => '750' }
vector << { :dirname => 'public', :perm => '755' }

vector.each do |i|
  puts "* Directorio #{i[:dirname]} y los permisos son #{i[:perm]}"
end
