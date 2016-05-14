#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
page_url = "https://www.google.com/shopping"


agent = Mechanize.new
page = agent.get(page_url)
google_form = page.form('gs')
#item = gets.strip
item_txt = File.open("item.txt", "r").first.strip
#pp item_txt
google_form.q = item_txt
#google_form.q = item
page = agent.submit(google_form, google_form.buttons.first)
#pp page.uri.to_s
url = page.uri.to_s


page = Nokogiri::HTML(open(url))
#puts page.class
#puts page.css('div div b')[0].text
#puts page.xpath("//div//div//b").text

total = 0
count = 0
loop_count = 0
while loop_count < 3 do
  if page.css('div div b')[count].text.include? "$"
    loop_count += 1
    amount = page.css('div div b')[count].text
    amount.delete! '$'
    amount = amount.to_f
    total += amount
    #pp total
  end
  count += 1
end
total /= 3
total = total.round(2)
#pp "The average price of a #{item} is $#{total}"
pp "The average price of a #{item_txt} is $#{total}"
