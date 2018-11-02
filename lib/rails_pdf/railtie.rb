require_relative 'pug_renderer.rb'

require 'pry'

module RailsPdf
  class Railtie < ::Rails::Railtie
    ActionView::Template.register_template_handler(:pug, RailsPdf::PugRenderer)

    ActionController::Base.prepend_view_path("app/pdf/layout")
    ActionController::Base.prepend_view_path("app/pdf")
    ActionController::Base.prepend_view_path("pdf")

    # binding.pry

    # ActionController::Base.paths["app/views"] << "app/pdf/layout"

    unless Mime::Type.lookup_by_extension(:pdf)
      Mime::Type.register_alias("application/pdf", :pdf)
    end
  end
end
