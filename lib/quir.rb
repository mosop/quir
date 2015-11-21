require "quir/version"

module Quir
  autoload :Loader, 'quir/loader'
  autoload :Inflection, 'quir/inflection'

  def self.later(&block)
    raise "No block given." unless block
    mod = block.binding.eval('self')
    dir = block.binding.eval('__FILE__').sub(/\.rb$/, '')
    loader = Loader.new(mod, dir)
    loader.run
  end
end
