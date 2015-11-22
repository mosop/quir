class Quir::Loader
  module Testspace
    module I_Run
      module DoesNotRedefineModule
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
