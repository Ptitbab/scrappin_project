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
    urls = get_townhall_urls
    townhall_emails =[]
    urls.each do |url| townhall_emails << get_townhall_email(url)
    end
   
    return townhall_emails
end


def get_array_final
    array_final = []
    emails = get_townhall_emails
    names = get_townhall_names
    number = emails.count
    for i in 0..number-1
        k = names[i]
        v = emails[i]
        array_final << Hash[k, v]
    end

    puts array_final
end

get_array_final
