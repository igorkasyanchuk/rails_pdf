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

  def RailsPDF.relaxed
    @@relaxed ||= begin 
      result = `which relaxed`.strip
      raise "RelaxedJS is not installed. Check https://github.com/igorkasyanchuk/rails_pdf#install-relaxedjs" if result.blank?
      result
    end
  end

end
