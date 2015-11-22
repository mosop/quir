require 'spec_helper'

RSpec.describe Quir::Loader do
  context '#autoload!' do
    it 'autoloads ruby files' do
      dir = "#{__dir__}/loader/#autoload!/-autoloads_ruby_files"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_defined?(:Mod1, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_get(:Mod1, false).class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_defined?(:Mod2, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod.const_get(:Mod2, false).class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::AutoloadsRubyFiles::Mod::Mod2.const_get(:Mod, false).class).to be(::Module)
    end

    it 'does not define module' do
      dir = "#{__dir__}/loader/#autoload!/-does_not_define_module"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::DoesNotDefineModule::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Loader::Testspace::I_Run::DoesNotDefineModule::Mod.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Loader::Testspace::I_Run::DoesNotDefineModule::Mod.const_get(:Mod, false).class).to be(::Module)
      expect(Quir::Loader::Testspace::I_Run::DoesNotDefineModule::Mod::Mod.const_defined?(:Mod, false)).to be(false)
    end

    it 'does not redefine module' do
      dir = "#{__dir__}/loader/#autoload!/-does_not_redefine_module"
      require "#{dir}/mod"
      Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod.const_set :Mod, Module.new
      l = Quir::Loader.new(Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Loader::Testspace::I_Run::DoesNotRedefineModule::Mod::Mod.const_defined?(:Mod, false)).to be(false)
    end
  end

  context '.from_binding' do
    def bind
      Kernel.binding
    end

    it 'creates instance from binding' do
      expect(Quir::Loader).to receive(:new).with(self.class, __FILE__.sub(/\.rb$/, ''))
      Quir::Loader.from_binding bind
    end
  end
end
