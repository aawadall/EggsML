#!/usr/bin/env python
# -*- encoding: utf-8 -*-

from eggsml_page import eggsml_page

class index:
    
    def __init__(self):
        t = open('template.html')
        temp = t.read()
        t.close()
        page = eggsml_page()
        i = page.index()
        print "Content-type: text/html; charset=UTF-8\n"
        print temp.replace('{{CONTENT}}', i)

index()
