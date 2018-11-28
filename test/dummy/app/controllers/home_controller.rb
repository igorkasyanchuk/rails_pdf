require 'open3'
require 'tempfile'

class BetterTempfile < Tempfile
  # ensures the Tempfile's filename always keeps its extension
  def initialize(filename, temp_dir = nil)
    temp_dir ||= Dir.tmpdir
    extension = File.extname(filename)
    basename  = File.basename(filename, extension)
    super([basename, extension], temp_dir)
  end
end

def PDFPugRender

  def initialize(template)
    @files = []
  end

  def render
    ApplicationController.render file: "/#{Rails.root}/app/pdf/report.pug.erb",
    layout: "application.pug.erb",
    locals: {
      renderer: self
    }
  end

  def inline

  end

end

class HomeController < ApplicationController
  def index
  end

  def report
    result = ApplicationController.render file: "/#{Rails.root}/app/pdf/report.pug.erb",
      layout: "application.pug.erb"

    Rails.logger.info "Result:\n\n#{result}"
    Rails.logger.info "====="

    begin
      input  = BetterTempfile.new("in.pug")
      output = BetterTempfile.new("out.pdf")

      input.write(result)
      input.flush

      #command = "relaxed #{input.path.to_s} #{output.path.to_s} --basedir #{Rails.root}/app/pdf/ --build-once"
      command = "relaxed #{input.path.to_s} #{output.path.to_s} --basedir / --build-once"
      #command = "relaxed #{input.path.to_s} #{output.path.to_s} --build-once"

      Rails.logger.info "=== #{command}"

      err = Open3.popen3(*command) do |_stdin, _stdout, stderr|
        puts _stdout.read
        puts '------'
        stderr.read
      end

      output.rewind
      output.binmode
      data = output.read

      send_data data, type: 'application/pdf', disposition: 'inline', filename: 'report.pdf'
    ensure
      input&.close!
      output&.close!
    end
  end
end
