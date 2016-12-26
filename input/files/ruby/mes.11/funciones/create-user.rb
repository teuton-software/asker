#!/usr/bin/ruby

def crear_usuario(nombre)
  puts "Crear usuario #{nombre}"
  puts "  adduser -m #{nombre}"
  puts "  mkdir /home/#{nombre}/private"
  puts "  mkdir /home/#{nombre}/group"
  puts "  mkdir /home/#{nombre}/public"
end

def borrar_usuario(nombre)
  puts "Borrar usuario #{nombre}"
  puts "  deluser -r #{nombre}"
end
