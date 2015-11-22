require 'spec_helper'

RSpec.describe Quir::Loader do
  context '#run' do
    it 'autoloads ruby files' do
      dir = "#{__dir__}/loader/#run/-autoloads_ruby_files"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod, "#{dir}/mod")
      l.run
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_defined?(:Mod1, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_get(:Mod1, false).class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_defined?(:Mod2, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_get(:Mod2, false).class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2.const_get(:Mod, false).class).to be(::Module)
    end

    it 'does not redefine module' do
      dir = "#{__dir__}/loader/#run/-does_not_redefine_module"
      require "#{dir}/mod"
      Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod.const_set :Mod, Module.new
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod, "#{dir}/mod")
      l.run
      expect(Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod::Mod.const_defined?(:Mod, false)).to be(false)
    end
  end
end
