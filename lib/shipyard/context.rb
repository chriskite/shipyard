class Context
  include ActiveSupport

  attr_reader :db, :table, :row, :dataset

  def initialize(manifest)
    @db = manifest.database
    @table = manifest.table.to_s
    @dataset = @db[manifest.table]
    @row = Inflector::singularize(manifest.table.to_s)
  end

  def columns
    columns_with_types.keys
  end

  def columns_with_types
    @db.schema(@table.to_sym).inject({}) { |r, v| r[v[0]] = v[1][:type]; r }
  end

  def primary_key
    @db.schema(@table.to_sym).select { |col_arr| col_arr[1][:primary_key] == true }.map { |col_arr| col_arr[0] }
  end

  def get_binding
    binding
  end

end
