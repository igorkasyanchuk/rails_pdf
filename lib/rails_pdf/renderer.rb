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

    def render(&block)
      content = ApplicationController.render(file: @file, layout: @layout)
  
      logger.debug "Content:\n\n#{content}"
      logger.debug "====="
  
      begin
        input  = BetterTempfile.new("in.pug")
        output = BetterTempfile.new("out.pdf")
  
        input.write(content)
        input.flush
  
        command = "/usr/bin/relaxed #{input.path.to_s} #{output.path.to_s} --basedir / --build-once"
  
        logger.debug "=== #{command}"
  
        err = Open3.popen3(*command) do |_stdin, _stdout, stderr|
          logger.info _stdout.read
          logger.info '------'
          logger.info stderr.read
        end

        output.rewind
        output.binmode

        data = output.read

        yield(data)
      ensure
        input&.close!
        output&.close!
      end
    end

    private

    def logger
      Rails.logger
    end

  end
end


