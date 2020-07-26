module Buildpack::Shell; end

module Buildpack::Commands
  class Test
    include Shell

    def self.detect(options)
      options[1] == "test"
    end

    def initialize(output_io, error_io, build_dir, env_dir)
      @output_io = output_io
      @error_io  = error_io
      @build_dir = build_dir
      @env_dir   = env_dir
    end

    def run
      BuildpackRunner.new(@output_io, @error_io, "heroku/nodejs-v98").test(@build_dir, @env_dir)
    end
  end
end
