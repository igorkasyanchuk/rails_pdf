class HomeController < ApplicationController
  def index
  end

  def report
    # RailsPDF.template("report/chart.pug.erb").render_to_file('x.pdf')
    # RailsPDF.template("report/chart.pug.erb").render_to_tempfile('x.pdf')
    #RailsPDF.template("report/chart.pug.erb").render do |data|
    #RailsPDF.template("report1/invoice.pug.erb").render do |data|
    RailsPDF.template("report2/invoice.pug.erb").render do |data|
      send_data(data, type: 'application/pdf', disposition: 'inline', filename: 'report.pdf')
    end
  end
end
