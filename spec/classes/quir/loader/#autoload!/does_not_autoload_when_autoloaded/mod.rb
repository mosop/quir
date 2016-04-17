module Quir::Testspaces
  module Quir
    module Loader
      module ID_Autoload
        module DoesNotAutoloadWhenAutoloaded
          module Mod
            autoload :Mod, __dir__ + '/mod/mod'
          end
        end
      end
    end
  end
end
