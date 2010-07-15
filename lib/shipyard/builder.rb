require 'sequel'
require 'ftools'
require 'erb'

module Shipyard
  class Builder 
    attr_reader :table
    attr_reader :db

    def initialize(manifest_file, table)
      @manifest = Manifest.new(manifest_file, table)
      @context = Context.new(@manifest)
    end

    def generate
      templates = Dir['*.erb']

      templates.each do |template|
        abort "No destination mapped for template '#{template}'" unless !!@manifest.destination_for(template)
      end

      puts "Rendering to output directory #{@manifest.output_dir}"
      templates.each do |filename|
        open(filename) do |file|
          # pass in the context object and render the template
          template = ERB.new(file.read)
          template.filename = filename
          code = template.result(@context.get_binding)
          
          # write the rendered file to the associated destination
          dst = @manifest.destination_for(filename)
          output_file = File.join(@manifest.output_dir, dst)
          File.makedirs(File.dirname(output_file))
          open(output_file, 'w') do |f|
            puts "\t#{filename} => #{output_file}"
            f.write(code)
          end
        end
      end
    end

  end
end
