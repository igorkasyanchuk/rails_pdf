class RailsPdfGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_helper_file
    report = args[0]

    if report.nil?
      puts "Please specify report template which you want to generate."
      puts "rails g rails_pdf invoice <name of report>"
      exit
    end

    directory "#{file_name}", "app/pdf/#{report}"
    gsub_file "app/pdf/#{report}/invoice.pug.erb", '<%= report %>', report
    directory "mixins", "app/pdf/mixins"
    directory "shared", "app/pdf/shared"
    directory "layouts", "app/pdf/layouts"
  end
end
