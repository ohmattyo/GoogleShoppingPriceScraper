#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
page_url = "https://www.google.com/shopping"


agent = Mechanize.new
page = agent.get(page_url)
google_form = page.form('gs')
item = gets.strip
google_form.q = item
page = agent.submit(google_form, google_form.buttons.first)
pp page.uri.to_s
url = page.uri.to_s


page = Nokogiri::HTML(open(url))
puts page.class
puts page.css('title')
puts page.css('b')[0].text
amount = page.css('b')[0].text
amount.delete! '$'
amount = amount.to_f
pp amount
