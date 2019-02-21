require "better_tempfile"
require "rails_pdf/version"
require "rails_pdf/railtie"

if defined?(Rails::Generators)
  require "generators/rails_pdf/rails_pdf_generator.rb"
end

module RailsPDF
  class << self
    def template(template_file)
      Renderer.new.template(template_file)
    end

    def layout(template_layout)
      Renderer.new.layout(template_layout)
    end
  end
end
