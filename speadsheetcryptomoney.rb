require 'google_drive'
require 'rubygems'
require 'nokogiri'

require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("13WmCpKTKvh-s9CM3V00bO1a7j3r-ZfozaJTQCxRXDng").worksheets[0] # on rajoute le lien obtenu par le partage du sheet sur le drive en supprimant le Https et le edit.

name_list = page.css('a.currency-name-container')

price_list = page.css('a.price')

j = 2

loop {

for i in 0 .. (name_list.length-1)

    ws[(i+1), 1] = name_list[i].text

    ws[(i+1), j] = price_list[i]['data-usd']

end

ws.save

sleep(120)

j+=1

}
