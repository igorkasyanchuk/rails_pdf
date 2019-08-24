require "open3"

module RailsPDF
  class Renderer
    def template(file)
      @file = file
      self
    end

    def layout(layout)
      @layout = layout
      self
    end

    def locals(locals)
      @locals = locals
      self
    end

    def render(&block)
      controller = ActionController::Base.new
      view = ActionView::Base.new(ActionController::Base.view_paths, {}, controller)
      params = { file: @file, layout: @layout }
      params = params.merge(locals: @locals) if @locals.present?
      content = view.render(params)

      logger.debug "RailsPDF ====="
      logger.debug "RailsPDF filename: #{@file.basename(path)}"
      logger.debug "RailsPDF content:\n#{content}"
      logger.debug "RailsPDF ====="

      begin
        input  = BetterTempfile.new("in-#{@file.basename(path)}")
        output = BetterTempfile.new("out.pdf")

        input.write(content)
        input.flush

        command = "#{RailsPDF.relaxed} #{input.path.to_s} #{output.path.to_s} --basedir / --build-once"

        logger.debug "RailsPDF ===== #{command}"

        err = Open3.popen3(*command) do |_stdin, _stdout, stderr|
          logger.debug _stdout.read
          logger.debug '------'
          logger.debug stderr.read
        end

        output.rewind
        output.binmode

        data = output.read

        yield(data)
      ensure
        input.try(:close!)
        output.try(:close!)
      end
    end

    def render_to_file(path_and_filename = "report.pdf")
      render do |data|
        File.open(path_and_filename, 'wb') do |f|
          f.write(data)
          f.close
        end
      end
    end

    def render_to_tempfile(filename = "report.pdf")
      render do |data|
        file = BetterTempfile.new(filename)
        file.binmode
        file.write(data)
        file.flush
        file
      end
    end

    private

    def logger
      Rails.logger
    end

  end
end


