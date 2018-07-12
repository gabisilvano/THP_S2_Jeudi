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
	page = Nokogiri::HTML(open(site))  
	names = [] #initialise les noms dans un tableau
	page.xpath('//span[@class="list_nom"]').each do |node|
		names << node.text.gsub('\n','').gsub(' ','')
		names	
	end
	binding.pry
	  deputy_mail = []
	  sites.each do |a|
	  entry_page = Nokogiri::HTML(open(a))
	  entry_page.xpath('//li/ul/li/a[@href]').each do |node|
	    if node.text.include?('@assem')
	      deputy_mail << node.text
	      break
	    end
	  end
	  #binding.pry
	  puts deputy_mail
	end
	binding.pry
 	 deputy = {} #initialise les 2 arrays dans un hash
	i = 0 
	names.each do |key| #key retourne la clé d'une valeur donnée
  	deputy["#{key}"]= deputy_mail[i] #pour chaque clé de 'currencies_values' on associe le [i] correspondant de 'values' 
  	i += 1 
	end
	puts deputy
end


deput('https://www.nosdeputes.fr/deputes')
