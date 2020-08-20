module Buildpack::Shell; end

module Buildpack::Commands
  class TestCompile
    include Shell

    def self.detect(options)
      options[1] == "test-compile"
    end

    def initialize(output_io, error_io, build_dir, cache_dir, env_dir)
      @output_io = output_io
      @error_io  = error_io
      @build_dir = build_dir
      @cache_dir = cache_dir
      @env_dir   = env_dir
    end

    def run
      buildpacks = %w(heroku/nodejs-v98 heroku/ember-cli-deploy)
      mktmpdir("exports") do |dir|
        buildpacks.inject([]) do |exports, name|
          export      = BuildpackRunner.new(@output_io, @error_io, name).test_compile(@build_dir, @cache_dir, @env_dir, exports)
          export_file = "#{dir}/#{name.split("/").last}"

          File.open(export_file, "w") do |file|
            file.puts export
          end

          exports + [export_file]
        end
      end
    end
  end
end
