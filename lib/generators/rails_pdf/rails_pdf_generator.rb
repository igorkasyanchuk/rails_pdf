class RailsPdfGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  TYPES = ["basic_invoice", "chart1", "simple_invoice", "new"]

  def create_helper_file
    report = args[0]

    if report.nil?
      puts "Please specify report starter template which you want to generate or \"new\" to create blank template."
      puts "Available types: #{TYPES.join(', ')}"
      puts "rails g rails_pdf <type> <name of report>"
      puts "sample: rails g rails_pdf #{TYPES[0]} report"
      exit
    end

    if !TYPES.include?(file_name)
      puts "Template not found. You can use any of: #{TYPES.join(', ')} "
      puts "sample: rails g rails_pdf #{TYPES[0]} report"
      return
    end

    directory "#{file_name}", "app/pdf/#{report}"

    case file_name
    when 'basic_invoice', 'simple_invoice'
      gsub_file "app/pdf/#{report}/invoice.pug.erb", '<%= report %>', report
    when 'chart1'
      gsub_file "app/pdf/#{report}/chart.pug.erb", '<%= report %>', report
    end

    directory "mixins", "app/pdf/mixins"
    directory "shared", "app/pdf/shared"
    directory "layouts", "app/pdf/layouts"
  end
end
