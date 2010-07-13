module Shipyard
  class Manifest
    attr_reader :maps
    attr_reader :db_conn_str

    def initialize(filename)
      @maps = {} 
      open(filename) { |file| instance_eval(file.read) }
    end

    def table(name = nil)
      @table = name if !!name
      @table
    end

    def database(conn_str)
      @db_conn_str = conn_str
    end

    def map(template, dst)
      @maps[template.to_sym] = dst
    end

  end
end
