#!/usr/bin/python

nombres = ['obi-wan', 'yoda', 'darth Vader']

for i in nombres:
    if i.startswith('darth'):
        print "Bye " + i.upper()
    else:
        print "Hello " + i.capitalize()
