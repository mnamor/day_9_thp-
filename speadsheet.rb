=begin
require "google_drive"
require 'rubygems'
require 'nokogiri'
require 'open-uri'
def get_all_the_urls_of_val_doise_townhalls()
	page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))
	session = GoogleDrive::Session.from_config("config.json")
	ws = session.spreadsheet_by_key("1v7XEnpGDtgjgRom3bp7OwzaK99zlUQIfKuW3QdawXBc").worksheets[0]
	cities = ""
	i = 1
	page.css('a.lientxt').each do |town|
		site = "https://annuaire-des-mairies.com" + town['href'][1..-1]
		cities = town.text
		ws[(i), 1] = cities
		ws[(i), 2] = get_the_email_of_a_townhal_from_its_webpage(site)
		i += 1
	end
	ws.save
end
def get_the_email_of_a_townhal_from_its_webpage (adresse)
	page = Nokogiri::HTML(open(adresse))
	return page.css('td.style27 p.Style22 font')[6].text
end
get_all_the_urls_of_val_doise_townhalls()
=end
require 'google_drive'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getwebsite()
	page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))
	session = GoogleDrive::Session.from_config("config.json")
	ws = session.spreadsheet_by_key("1v7XEnpGDtgjgRom3bp7OwzaK99zlUQIfKuW3QdawXBc").worksheets[0]
	cities = ""
	i = 1
	page.css('a.lientxt').each do |town|
		site = "https://annuaire-des-mairies.com" + town['href'][1..-1]
		cities = town.text
		ws[(i), 1] = cities
		ws[(i), 2] = getemail(site)
		i += 1
	end
	ws.save
end
def getemail (adresse)
	page = Nokogiri::HTML(open(adresse))
	return page.css('td.style27 p.Style22 font')[6].text
end
getwebsite()
