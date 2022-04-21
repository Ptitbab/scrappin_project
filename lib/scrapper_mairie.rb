require 'rubygems'
require 'nokogiri'
require 'open-uri'




def get_townhall_email(url)
    page = Nokogiri::HTML(URI.open(url))

    puts page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
end

def get_townhall_names
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
   townhall_names =[]
 

    page.xpath("//a[contains(@href, '95')]").each do |name| townhall_names << name.text
    end
    return townhall_names
end

def get_townhall_urls
    
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

    townhall_urls = []
    page.xpath("//a[contains(@href, '95')]").each do |url|  
      townhall_urls <<  "http://annuaire-des-mairies.com" + url['href'][1..-1]
    end

    return townhall_urls
end


def get_townhall_emails
    get_townhall_urls
    townhall_emails = []
    townhall_urls.each do |url| townhall_emails << get_townhall_email(url)
    end
end


def get_array_final
    array_final = []
    for i in 0..10
        k = get_townhall_names[i]
        v = get_townhall_emails[i]
        array_final << Hash[k, v]
    end

    return array_final
end

puts get_townhall_emails