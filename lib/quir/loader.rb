using Quir::Inflection

module Quir
  class Loader
    def initialize(mod, dir)
      @module = mod
      @dir = dir
    end

    def self.from_binding(binding)
      mod = binding.eval('self')
      dir = binding.eval('__FILE__').sub(/\.rb$/, '')
      Loader.new(mod, dir)
    end

    attr_reader :module, :dir

    def autoload!
      ::Dir.glob("#{dir}/*") do |f|
        if ::File.directory?(f)
          autoload_directory f
        elsif /\.rb$/ =~ f
          autoload_ruby_file f
        end
      end
    end

    def autoload_directory(d)
      return if ::File.exist?("#{d}.rb")
      name = d.split(/\//)[-1].pascalize
      return if self.module.const_defined?(name, false)
      m = ::Module.new
      self.module.const_set name, m
      m.name # fix module's name
      loader = ::Quir::Loader.new(m, d)
      loader.autoload!
    end

    def autoload_ruby_file(f)
      name = f.split(/\//)[-1].sub(/\.rb$/, '').pascalize
      self.module.autoload name, f unless self.module.autoload?(name)
    end
  end
end
