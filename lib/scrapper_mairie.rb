require 'rubygems'
require 'nokogiri'
require 'open-uri'

townhall_urls = []


def get_townhall_email
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/andilly.html"))

    puts page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
end


def get_townhall_urls
    
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

    townhall_urls = []
    page.xpath("//a[contains(@href, '95')]").each do |url|  
      townhall_urls <<  "http://annuaire-des-mairies.com" + url['href'][1..-1]
    end

    return townhall_urls
end

puts get_townhall_urls