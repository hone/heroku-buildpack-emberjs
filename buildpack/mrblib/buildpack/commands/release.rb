module Buildpack::Commands
  class Release
    FILE_PATH = "tmp/heroku-buildpack-release.yml"

    def self.detect(options)
      options[1] == "release"
    end

    def initialize(output_io, error_io, build_dir)
      @output_io = output_io
      @error_io  = error_io
      @build_dir = build_dir
      @release_file = "#{@build_dir}/#{FILE_PATH}"
    end

    def run
      contents = File.exist?(@release_file) ? File.read(@release_file) : "--- {}"
      @output_io.puts contents
    ensure
      FileUtilsSimple.rm(@release_file) if File.exist?(@release_file)
    end
  end
end
