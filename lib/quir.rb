require "quir/version"

module Quir
  autoload :Inflection, 'quir/inflection'
  autoload :Loader, 'quir/loader'
  autoload :Testspaces, 'quir/testspaces'

  def self.autoload!(&block)
    raise "No block given." unless block
    Loader.from_binding(block.binding, &block).autoload!
  end
end
