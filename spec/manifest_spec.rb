require File.dirname(__FILE__) + '/spec_helper'

module Shipyard 
  describe Manifest do

    before(:each) do
      @test_manifest = 'test.manifest'
      File.open(@test_manifest, 'w') do |file|
        file.write <<-EOF
          self.schematic = 'test.schematic'
        EOF
      end
    end

    after(:each) do
      File.unlink(@test_manifest)
    end

    it "should read instance variables from a manifest file" do
      m = Manifest.new(@test_manifest)
      m.schematic.should == 'test.schematic'
    end

  end
end
