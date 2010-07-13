require File.dirname(__FILE__) + '/spec_helper'
require 'pp'

module Shipyard 
  describe Context do

    before(:each) do
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

    it "should read the table name from the manifest" do
      ctx = Context.new(@m)
      ctx.table.should == 'test_table' 
    end

    it "should have a method to return the columns of the table" do
      ctx = Context.new(@m)
      ctx.db.create_table :test_table do 
        primary_key :id
        String :name
      end
      ctx.columns.should == [:id, :name]
    end

    it "should have a method to return the columns with their types" do
      ctx = Context.new(@m)
      ctx.db.create_table :test_table do 
        primary_key :id
        column :name, :text
        column :count, :integer
      end

      ctx.columns_with_types.should == {:id => :integer, :name => :string, :count => :integer}
    end

  end
end
