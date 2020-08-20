module Buildpack::Shell; end

module Buildpack::Commands
  class Compile
    include Shell

    STATIC_JSON = "package.json"

    def self.detect(options)
      options[1] == "compile"
    end

    def initialize(output_io, error_io, build_dir, cache_dir, env_dir)
      @output_io = output_io
      @error_io  = error_io
      @build_dir = build_dir
      @cache_dir = cache_dir
      @env_dir   = env_dir
    end

    def run
      buildpacks = %w(heroku/nodejs heroku/ember-cli-deploy)
      fastboot   = dependencies["ember-cli-fastboot"]
      buildpacks << "heroku/static" unless fastboot

      npm_config_production_file = "#{@env_dir}/NPM_CONFIG_PRODUCTION"
      if Dir.exist?(@env_dir) && !File.exist?(npm_config_production_file)
        @output_io.topic "Setting NPM_CONFIG_PRODUCTION to false to install ember-cli toolchain"
        File.open("#{@env_dir}/NPM_CONFIG_PRODUCTION", 'w') do |file|
          file.puts "false"
        end
      end

      rets = []
      mktmpdir("exports") do |dir|
        rets = buildpacks.inject([]) do |acc, name|
          exports = acc.inject([]) {|list, entry| list << entry[1] }
          release, export = BuildpackRunner.new(@output_io, @error_io, name).run(@build_dir, @cache_dir, @env_dir, exports)
          export_file     = "#{dir}/#{name.split("/").last}"

          File.open(export_file, "w") do |file|
            file.puts export
          end

          acc << [release, export_file]
        end
      end

      release_file = "#{@build_dir}/#{Release::FILE_PATH}"
      FileUtilsSimple.mkdir_p("#{@build_dir}/tmp")
      File.open(release_file, "w") do |file|
        file.puts YAML.dump(rets.last[0])
      end
    end

    private
    def dependencies
      unless @dependencies
        json = JSON.parse(File.read("#{@build_dir}/#{STATIC_JSON}"))
        @dependencies = (json["devDependencies"] || {}).merge(json["dependencies"] || {})
      end

      @dependencies
    end
  end
end
