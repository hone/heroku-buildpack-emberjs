module Buildpack::Commands
  class Detect
    def self.detect(options)
      options[1] == "detect"
    end

    def initialize(output_io, error_io, build_dir)
      @output_io = output_io
      @error_io  = error_io
      @build_dir = build_dir
    end

    def run
      package_json_path = "#{@build_dir}/package.json"
      if File.exist?(package_json_path)
        json = JSON.parse(File.read(package_json_path))

        if (json["devDependencies"] || {}).merge(json["dependencies"] || {})["ember-cli"]
          @output_io.puts "emberjs"
          exit 0
        end
      end

      exit 1
    end
  end
end
