class RailsPdfGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_helper_file
    report = args[0]

    if report.nil?
      puts "Please specify report template which you want to generate."
      puts "rails g rails_pdf invoice <name of report>"
      exit
    end

    case file_name
    when 'basic_invoice'
      directory "#{file_name}", "app/pdf/#{report}"
      gsub_file "app/pdf/#{report}/invoice.pug.erb", '<%= report %>', report
    when 'chart1'
      directory "#{file_name}", "app/pdf/#{report}"
      gsub_file "app/pdf/#{report}/chart.pug.erb", '<%= report %>', report
    else
      puts "Template not found. You can use any of: basic_invoice, chart1, "
    end




    directory "mixins", "app/pdf/mixins"
    directory "shared", "app/pdf/shared"
    directory "layouts", "app/pdf/layouts"
  end
end
