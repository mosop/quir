require 'spec_helper'

describe Quir do
  it 'has a version number' do
    expect(Quir::VERSION).not_to be nil
  end

  context '.later' do
    it 'raises "No block given"' do
      expect{ Quir.later }.to raise_error('No block given.')
    end
  end
end
