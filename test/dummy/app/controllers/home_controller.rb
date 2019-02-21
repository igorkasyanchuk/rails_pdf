class HomeController < ApplicationController
  def index
  end

  def report
    # RailsPDF.template("report1/invoice.pug.erb").render do |data|
    #   f = File.open("file.pdf", "wb")
    #   f.write(data)
    #   f.close
    # end
    RailsPDF.template("report1/invoice.pug.erb").render do |data|
      sleep(rand(0.2))
      send_data(data, type: 'application/pdf', disposition: 'inline', filename: 'report.pdf')
    end
  end
end
