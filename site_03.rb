require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "pry"


def deput (site)

	page = Nokogiri::HTML(open(site))  
	sites = [] 
	page.xpath('//td/a').each do |node|
	sites << site + node.values[0]
	puts sites	
	end
end  

def deput_name (site)

	page = Nokogiri::HTML(open(site))  
	names = [] #initialise les noms dans un tableau
	page.xpath('//span[@class="list_nom"]').each do |node|
		names << node.text.gsub('\n','').gsub(' ','')
		puts names	
	end
end  

def get_deputy_mail(page)

  deputy_mail = ''
  entry_page = Nokogiri::HTML(open(page))
  entry_page.xpath('//li/a').each do |node|
    # binding.pry
    if node.text.include?('@assem')
      deputy_mail = node.text
    end
  end
  deputy_mail
end


deput_name ('https://www.nosdeputes.fr/deputes')
