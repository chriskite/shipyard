require 'sequel'
require 'ftools'
require 'erb'

module Shipyard
  class Builder 
    attr_reader :table
    attr_reader :db

    def initialize(manifest_file)
      @manifest = Manifest.new(manifest_file)
      @context = Context.new(@manifest)
    end

    def generate
      Dir['*.erb'].each do |filename|
        open(filename) do |file|
          # pass in the context object and render the template
          template = ERB.new(file.read)
          template.filename = filename
          code = template.result(@context.get_binding)
          
          # write the rendered file to the associated destination
          output_file = File.join(@manifest.output_dir, @manifest.destination_for(filename))
          File.makedirs(File.dirname(output_file))
          open(output_file, 'w') { |f| f.write(code) }
        end
      end
    end

  end
end
