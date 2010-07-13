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

    def map(template, dst)
      @maps[template.to_sym] = dst
    end

  end
end
