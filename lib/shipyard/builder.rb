require 'sequel'

module Shipyard
  class Builder 
    attr_reader :table
    attr_reader :db

    def initialize(db_conn_str, table_name, manifest_file)
      @table = @db[table_name.to_sym]
      @manifest = Manifest.new(manifest_file)
    end

    def generate
      # for each template file
        # pass in the db object and render the template
        # write the rendered file to the associated destination
    end

  end
end
