module Buildpack::Commands
  class Version
    def self.detect(options)
      options[1] == "--version" || options[1] == "-v"
    end

    def initialize(output_io, error_io)
      @output_io = output_io
      @error_io  = error_io
    end

    def run
      @output_io.puts Buildpack::VERSION
    end
  end
end
