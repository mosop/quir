require 'spec_helper'

RSpec.describe Quir::Loader do
  context '#autoload!' do
    it 'autoloads' do
      dir = "#{__dir__}/loader/#autoload!/autoloads"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod, "#{dir}/mod")
      l.autoload!
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod.const_defined?(:Mod1, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod.const_get(:Mod1, false).class).to be(::Module)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod.const_defined?(:Mod2, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod.const_get(:Mod2, false).class).to be(::Module)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod::Mod2.const_defined?(:Mod, false)).to be(true)
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::Autoloads::Mod::Mod2.const_get(:Mod, false).class).to be(::Module)
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

    it 'does not autoload when autoloaded' do
      dir = "#{__dir__}/loader/#autoload!/does_not_autoload_when_autoloaded"
      require "#{dir}/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotAutoloadWhenAutoloaded::Mod, "#{dir}/mod")
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotAutoloadWhenAutoloaded::Mod.singleton_class).not_to receive(:autoload)
      l.autoload!
    end

    it 'does not autoload when defiend' do
      dir = "#{__dir__}/loader/#autoload!/does_not_autoload_when_defined"
      require "#{dir}/mod"
      require "#{dir}/mod/mod"
      l = Quir::Loader.new(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotAutoloadWhenDefined::Mod, "#{dir}/mod")
      expect(Quir::Testspaces::Quir::Loader::ID_Autoload::DoesNotAutoloadWhenDefined::Mod.singleton_class).not_to receive(:autoload)
      l.autoload!
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
