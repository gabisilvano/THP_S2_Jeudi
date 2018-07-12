require 'rubygems'
require 'nokogiri'
require 'open-uri'


def crypto (site)

page = Nokogiri::HTML(open(site))   
values = [] #initialise les données dans un tableau
find = page.css('a[class = "price"]') #scrapp la classe des prix
find.each do |value| 
  values << value["data-usd"] # "<<" permet de mettre la valeur USD jusqu'à la fin de l'array
end
currencies = [] #intialise les données dans un tableau
find.each do |currency| 
  currencies << currency["href"].gsub!("/currencies/","").gsub!("/#markets","")
  #gsub ou sub (substituion) remplace chaque occurence de /currencies/ et /#markets pour le remplacer par un string vide, ce qui affiche le nom de la crypto correspondante
end
currencies_values = {} #initialise les 2 arrays dans un hash
i = 0 
currencies.each do |key| #key retourne la clé d'une valeur donnée
  currencies_values["#{key}"]= values[i] #pour chaque clé de 'currencies_values' on associe le [i] correspondant de 'values' 
  i += 1 
end
puts currencies_values #affiche le hash
end

loop do

crypto ('https://coinmarketcap.com/all/views/all/')
puts ""
sleep 3600
end