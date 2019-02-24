require "better_tempfile"
require "rails_pdf/version"
require "rails_pdf/railtie"

if defined?(Rails::Generators)
  require "generators/rails_pdf/rails_pdf_generator.rb"
end

module RailsPDF
  class << self
    delegate :template, :layout, to: :instance
  end
  def RailsPDF.instance
    Renderer.new
  end
end
