require 'ostruct'

module Shipyard
  class Manifest < OpenStruct

    def initialize(filename)
      super
      open(filename) { |file| instance_eval(file.read) }
    end

  end
end
