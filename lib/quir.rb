require "quir/version"

module Quir
  autoload :Loader, 'quir/loader'
  autoload :Inflection, 'quir/inflection'

  def self.autoload!(&block)
    raise "No block given." unless block
    Loader.from_binding(block.binding).autoload!
  end
end
