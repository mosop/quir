module Quir
  module Inflection
    autoload :String, 'quir/inflection/string'

    refine ::String do
      include String::Pascalize
    end
  end
end
