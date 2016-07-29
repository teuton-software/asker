#!/usr/bin/ruby

require 'shoes'

Shoes.app {
  button("Click") {
    alert("Hola Mundo!")
  }
}
