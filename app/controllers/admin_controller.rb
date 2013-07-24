class AdminController < ApplicationController

  def index
    @printers = get_printers
  end

  def get_printers
    response = RestClient.get( APP_CONFIG['repetier_uri'] + '/printer/list' )
    response = JSON.parse( response )
    
    response.each do |server|
      printer = Printer.where( name: server['name'] )
      printer = Printer.new unless printer
      printer.name = server['name']
      printer.slug = server['slug']
      printer.online = server['online']
      printer.save!
    end

    Printer.all
  end
end

