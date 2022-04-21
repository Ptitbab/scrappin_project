require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))


currency_symbols = []
currency_prices = []
crypto_symbols_and_prices = []

 
page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol']//div").each do |symbol|  currency_symbols << symbol.text end


page.xpath("//div[@class='sc-131di3y-0 cLgOOr']//span").each do |price| currency_prices << price.text[1..-1] end


for i in 0..19
    k=currency_symbols[i]
    v=currency_prices[i]
    crypto_symbols_and_prices << Hash[k,v]
end


puts crypto_symbols_and_prices



