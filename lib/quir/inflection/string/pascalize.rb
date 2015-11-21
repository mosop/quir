module Quir::Inflection::String
  module Pascalize
    def pascalize
      split(/_/).map{|i| i[0].upcase + i[1..-1]}.join('')
    end
  end
end
