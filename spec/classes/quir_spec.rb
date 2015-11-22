require 'spec_helper'

describe Quir do
  it 'has a version number' do
    expect(Quir::VERSION).not_to be nil
  end

  context '.autoload!' do
    it 'raises "No block given"' do
      expect{ Quir.autoload! }.to raise_error('No block given.')
    end

    it 'autoloads' do
      block = Kernel.eval("class #{self.class.name}; proc {}; end")
      block_binding = block.binding
      loader = Quir::Loader.from_binding(block.binding)
      allow(block).to receive(:binding).and_return(block_binding)
      expect(Quir::Loader).to receive(:from_binding).with(block_binding).and_return(loader)
      expect(loader).to receive(:autoload!)
      Quir.autoload! &block
    end
  end
end
