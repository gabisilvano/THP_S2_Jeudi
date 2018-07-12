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
  noms = []
  prenoms = []
  page.xpath('//span[@class="list_nom"]').each do |node|
    names_char = node.text.gsub(' ','').gsub("\n",'')
    i = 0
    names_char.each_char do |char|
    	if char != ","
    	 	i += 1
    	elsif  char == ","  	
    		nom = names_char[0..i-1]
    		prenom = names_char[i+1..names_char.size]
    		noms << nom
    		prenoms << prenom
    	end
    	#binding.pry	
    	
    end
    
    names
   # binding.pry	
  end
  
  deputy_mail = []
  sites.each do |a|
    entry_page = Nokogiri::HTML(open(a))
    entry_page.xpath('//li/ul/li/a[@href]').each do |node|
      if node.text.include?('@assem')
        deputy_mail << node.text
        break
      end
    end

   puts deputy_mail
  end
  
  deputy = {} #initialise les 2 arrays dans un hash
  j = 0 
  while j < noms.length
    deputy["Name"]= noms #pour chaque clé de 'currencies_values' on associe le [i] correspondant de 'values' 
    deputy["Surname"]= prenoms
    deputy["Mail"]= deputy_mail
    j += 1 
  end
  puts deputy
end


deput('https://www.nosdeputes.fr/deputes')
