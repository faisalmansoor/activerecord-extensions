ActiveRecord::QueryMethods.module_eval do
  def bind_parameters(opts)
    binds = []
    opts.each do |(column, value)|
      if(value.nil?)
        raise ArgumentError.new("nils are not allowed in bind parameter. please sanitize value for column: '#{column}'")
      end
      binds.push [@klass.columns_hash[column.to_s], value]
    end
    self.bind_values += binds
    self
  end
end
