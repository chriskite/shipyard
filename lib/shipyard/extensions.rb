require 'active_support/inflector'

class String
  ActiveSupport::Inflector.methods.grep(/ize|fy$/).each do |method|
    define_method(method) { ActiveSupport::Inflector.send(method.to_sym, self) }
  end
end
