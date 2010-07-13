require 'sequel'

module Shipyard
  class Builder 
    attr_reader :table
    attr_reader :db

    def initialize(db_conn_str, table_name, manifest_file)
      #'mysql://offers_admin:2ownOffers@localhost/offers_admin'
      @db = Sequel.connect(db_conn_str)
      @table = @db[table_name.to_sym]
      @manifest = Shipyard::Manifest.new(manifest_file)
    end

  end
end
