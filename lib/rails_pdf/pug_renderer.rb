module RailsPdf
  class PugRenderer
    # ActionController::Renderers.add :pug do |filename, options|
    #   binding.pry
    # end

    def render(options = {}, local_assigns = {}, &block)
      binding.pry
    end

    def self.call(template)
      binding.pry
      %{
        @filename ||= "\#{controller.action_name}.pdf"
        if controller.respond_to?(:response) && !controller.response.nil?
          controller.response.headers['Content-Disposition'] = "inline; filename=\\\"\#{@filename}\\\""
        end
        #{template.source.strip}
      }
    end

  end
end


