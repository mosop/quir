require 'spec_helper'

RSpec.describe Quir::Loader do
  context '#run' do
    it 'autoloads ruby files' do
      dir = "#{__dir__}/loader/#run/autoloads_ruby_files/mod"
      require dir
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod, dir)
      l.run
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod1.class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2.class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2::Mod.class).to be(::Module)
    end
  end
end
