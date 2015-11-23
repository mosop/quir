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
      self.new(mod, dir)
    end

    attr_reader :module, :dir

    def autoload!
      ::Dir.glob("#{dir}/*", ::File::FNM_DOTMATCH) do |f|
        next if /\/\.{1,2}$/ =~ f
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
      m = define_module(name, d)
      loader = self.class.new(m, dir)
      loader.autoload!
    end

    def define_module(name, dir)
      m = ::Module.new
      self.module.const_set name, m
      m.name # fix module's name
      initialize_module m, dir
      m
    end

    def initialize_module(mod, dir)
    end

    def autoload_ruby_file(f)
      name = f.split(/\//)[-1].sub(/\.rb$/, '')
      /^([#.])?(.+?)([?!])?$/ =~ name
      s1 = {'#' => 'I', '.' => 'C'}[$1]
      s2 = {'?' => 'P', '!' => 'D'}[$3]
      name = (s1 || s2 ? "#{s1}#{s2}_" : '') + $2.pascalize
      self.module.autoload name, f unless self.module.autoload?(name)
    end
  end
end
