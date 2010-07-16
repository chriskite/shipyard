class Context

  attr_reader :db, :table, :row, :dataset

  def initialize(manifest)
    @db = manifest.database
    @table = manifest.table
    @row = manifest.row
    @dataset = @db[manifest.table]
  end

  def columns
    @db.schema(@table.to_sym).map { |arr| arr[0].to_s }
  end

  def columns_with_types
    @db.schema(@table.to_sym).inject({}) { |r, v| r[v[0].to_s] = v[1][:type]; r }
  end

  def primary_key
    @db.schema(@table.to_sym).select { |col_arr| col_arr[1][:primary_key] == true }.map { |col_arr| col_arr[0].to_s }.first
  end

  def get_binding
    binding
  end

end
