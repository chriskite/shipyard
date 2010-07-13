require 'forwardable'

class Context
  extend Forwardable

  attr_reader :db, :table
  def_delegators :@dataset, :columns

  def initialize(manifest)
    @db = manifest.database
    @table = manifest.table.to_s
    @dataset = @db[manifest.table]
  end

  def columns_with_types
    @db.schema(@table.to_sym).inject({}) { |r, v| r[v[0]] = v[1][:type]; r }
  end

  def get_binding
    binding
  end

end
