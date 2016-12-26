#!/usr/bin/ruby

require 'sinatra'

get '/' do
  "index html"
end

get '/adios' do
  "Adios hola desde sinatra"
end

get '/usuario' do
  content = `ls`
  files = content.split("\n")
  salida = "<ul>"

  files.each { |i| salida += "<li>"+i+"</li>" }
  salida += "</ul>"

  salida
end
