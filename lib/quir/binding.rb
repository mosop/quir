class Binding
  def quir
    ::Quir::Loader.from_binding(self)
  end
end
