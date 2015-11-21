module Quir
  module Inflection
    autoload :String, 'quir/inflection/string/pascalize'

    refine ::String do
      include String::Pascalize
    end
  end
end
