require 'open-uri'
require 'nokogiri'
require 'pry'


def get_the_email_of_a_townhal_from_its_webpage (site)
	mail = []
	page = Nokogiri::HTML(open(site))
	page.xpath("//td").each do |node|
    mail << node.text if node.text.include?("@")
  end
	puts mail
	#items = page.xpath("//div/a/h4").collect {|node| puts node.text.strip}	
end

get_the_email_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/vaureal.html")