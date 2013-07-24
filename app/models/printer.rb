class Printer < ActiveRecord::Base
  attr_accessible :address, :name, :status, :online, :slug

  def self.get_printers
    response = RestClient.get( APP_CONFIG['repetier_uri'] + '/printer/list' )
    response = JSON.parse( response )
    
    response['data'].each do |server|
      printer = Printer.where( name: server['name'] )
      
      if printer.first
        printer = printer.first
      else
        printer = Printer.new
      end

      printer.name = server['name']
      printer.slug = server['slug']
      printer.online = server['online']
      printer.save!
    end

    Printer.all
  end
end
