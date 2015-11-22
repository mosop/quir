class Quir::Loader
  module Testspace
    module I_Run
      module DoesNotDefineModule
        module Mod
          module Mod
            module Mod
            end
          end
        end
      end
    end
  end
end
