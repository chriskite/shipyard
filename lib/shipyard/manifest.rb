module Shipyard
  class Manifest
    attr_reader :maps

    def initialize(filename)
      @maps = {} 
      open(filename) { |file| instance_eval(file.read) }
    end

    def table(name = nil)
      @table = name if !!name
      @table
    end

    def database(sequel = nil)
      @database = sequel if !!sequel
      @database
    end

    def output_dir(dir = nil)
      @output_dir = dir if !!dir
      @output_dir
    end

    def map(template, dst)
      @maps[template.to_sym] = dst
    end

    def destination_for(filename)
      @maps[filename.gsub(/\.erb/, '').to_sym]
    end
  end
end
