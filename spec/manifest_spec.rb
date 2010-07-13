require File.dirname(__FILE__) + '/spec_helper'

module Shipyard 
  describe Manifest do

    before(:each) do
      @test_db = 'test.db'
      @test_dir = 'test_manifest'
      Dir.mkdir(@test_dir)
      @test_manifest = File.join(@test_dir, 'Manifest')
      File.open(@test_manifest, 'w') do |file|
        file.write <<-EOF
          table :test_table

          database Sequel.sqlite 

          map :test_template, 'controllers/test.rb'
        EOF
      end
      @m = Manifest.new(@test_manifest)
    end

    after(:each) do
      File.unlink(@test_manifest)
      Dir.unlink(@test_dir)
      @m = nil
    end

    it "should read a table name from the manifest file" do
      @m.table.should == :test_table
    end

    it "should map template files to their output files" do
      @m.maps[:test_template].should == 'controllers/test.rb' 
    end

    it "should get a Sequel database connection from the manifest file" do
      @m.database.should be_a_kind_of Sequel::SQLite::Database
    end

  end
end
