require 'spec_helper'

RSpec.describe Quir::Loader do
  context '#autoload!' do
    it 'autoloads ruby files' do
      dir = "#{__dir__}/loader/#autoload!/autoloads_ruby_files"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod.const_defined?(:Mod1, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod.const_get(:Mod1, false).class).to be(::Module)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod.const_defined?(:Mod2, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod.const_get(:Mod2, false).class).to be(::Module)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod::Mod2.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::AutoloadsRubyFiles::Mod::Mod2.const_get(:Mod, false).class).to be(::Module)
    end

    it 'does not define module' do
      dir = "#{__dir__}/loader/#autoload!/does_not_define_module"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotDefineModule::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotDefineModule::Mod.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotDefineModule::Mod.const_get(:Mod, false).class).to be(::Module)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotDefineModule::Mod::Mod.const_defined?(:Mod, false)).to be(false)
    end

    it 'does not redefine module' do
      dir = "#{__dir__}/loader/#autoload!/does_not_redefine_module"
      require "#{dir}/mod"
      Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotRedefineModule::Mod.const_set :Mod, Module.new
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotRedefineModule::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotRedefineModule::Mod::Mod.const_defined?(:Mod, false)).to be(false)
    end

    it 'handles special character' do
      dir = "#{__dir__}/loader/#autoload!/handles_special_character"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:CD_ClassDangerous)).not_to be(nil)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:CP_ClassPredicate)).not_to be(nil)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:C_Class)).not_to be(nil)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:ID_InstanceDangerous)).not_to be(nil)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:IP_InstancePredicate)).not_to be(nil)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::HandlesSpecialCharacter::Mod.autoload?(:I_Instance)).not_to be(nil)
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

    it 'creates instance of self class' do
      dir = "#{__dir__}/loader/.from_binding/creates_instance_of_self_class"
      require "#{dir}/loader"
      klass = Quir::Testspaces::Quir::Loader::CI_FromBinding::CreatesInstanceOfSelfClass::Loader
      l = klass.from_binding(bind)
      expect(l.class).to be(klass)
    end
  end
end
