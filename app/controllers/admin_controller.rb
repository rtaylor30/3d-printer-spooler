class AdminController < ApplicationController

  def index
    @printers = Printer.get_printers
  end

end

