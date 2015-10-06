ActiveRecord::QueryMethods.module_eval do
  def bind_parameters(opts)
    opts = ActiveRecord::PredicateBuilder.resolve_column_aliases(klass, opts)
    _, bind_values = create_binds(opts)
    self.bind_values += bind_values
    self
  end
end
