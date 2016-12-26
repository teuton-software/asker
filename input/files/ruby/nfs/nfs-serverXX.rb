#!/usr/bin/ruby
require 'pry'

# Comprobar que soy root
usuario = `whoami`
if usuario != 'root\n'
  puts 'Hay que ser el usuario root'
#  exit 1
end

if ARGV.size==0
  puts "Debes poner"
  puts " --install, para instalar"
  puts " --remove, para desintalar"
  exit 1
end

if ARGV[0]=='--install' then
  puts "VOY A INSTALAR ESTO"
  # Instalar el servidor NFS
  puts('zypper install nfs-sever')

  # Crear la carpetas
  dirname = '/srv/exportXX/private'
  puts("mkdir #{dirname}")
  puts("chmod 770 #{dirname}")
  puts("chown nobody:nogroup #{dirname}")

  dirname = '/srv/exportXX/public'
  puts("mkdir #{dirname}")
  puts("chmod 770 #{dirname}")
  puts("chown nobody:nogroup #{dirname}")

  # Configurar fichero exports
  linea = '/srv/exportXX/private 172.18.XX.32/32(ro,sync,subtree_check)'
  system("echo \"#{linea}\" > export.demo")

  linea = '/srv/exportXX/public *(rw,sync,subtree_check)'
  system("echo \"#{linea}\" >> export.demo")
elsif ARGV[0]=='--remove' then
  puts "VOY A DESINSTALAR ESTO"
  # Eliminar la carpetas
  dirname = '/srv/exportXX/'
  puts("rm -r #{dirname}")
  # Configurar fichero exports
  linea = '# Fichero vacío'
  system("echo \"#{linea}\" > export.demo")

  puts "zypper remove nfs-server"
end
