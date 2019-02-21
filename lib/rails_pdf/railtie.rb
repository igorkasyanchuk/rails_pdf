require_relative 'renderer.rb'

require 'pry'

module RailsPDF
  class Railtie < ::Rails::Railtie
    ActionController::Base.prepend_view_path("app/pdf")
  end
end
