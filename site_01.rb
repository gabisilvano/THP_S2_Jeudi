require 'open-uri'
require 'nokogiri'
require 'pry'
def get_the_email_of_a_townhal_from_its_webpage(site)
  mail = []
  page = Nokogiri::HTML(open(site))
  page.xpath('//td').each do |node|
    mail << node.text if node.text.include?('@')
  end
  puts mail
	
end

def get_all_the_urls_of_val_doise_townhalls(link, city)

  site_1 = ''
  city_name = []
  city_link = ''
  Nokogiri::HTML(open(link)).xpath('//a').each do |node|
    site_1 = link + node.values[1] if node.text.include?(city)
  end
  site_2 = Nokogiri::HTML(open(site_1))
  site_2.xpath('//a[@class]').each do |node|
    city_name << node.values[1] if node.values[1][0].include?('.')
  end
  city_name.each do |a|
    link_3 = link + a[1..a.length - 1]
    get_the_email_of_a_townhal_from_its_webpage link_3
  end
end

get_all_the_urls_of_val_doise_townhalls('http://annuaire-des-mairies.com/', "95 | Val-d'Oise")
