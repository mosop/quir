using Quir::Inflection

module Quir
  class Loader
    attr_reader :binding

    def initialize(mod, dir)
      @module = mod
      @dir = dir
    end

    attr_reader :module, :dir

    def run
      ::Dir.glob("#{dir}/*") do |f|
        if ::File.directory?(f)
          append_directory f
        elsif /\.rb$/ =~ f
          append_ruby_file f
        end
      end
    end

    def append_directory(d)
      return if ::File.exist?("#{dir}/#{d}.rb")
      name = d.split(/\//)[-1].pascalize
      m = ::Module.new
      self.module.const_set name, m
      m.name # fix module's name
      loader = ::Quir::Loader.new(m, d)
      loader.run
    end

    def append_ruby_file(f)
      name = f.split(/\//)[-1].sub(/\.rb$/, '').pascalize
      self.module.autoload name, f unless self.module.autoload?(name)
    end
  end
end
