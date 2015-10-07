module ActiverecordExtensions
  module QueryBuilder

    def where_gt(attribute, value)
      where_with_bind(arel_table[attribute].gt(Arel::Nodes::BindParam.new), {attribute => value})
    end

    def where_lt(attribute, value)
      where_with_bind(arel_table[attribute].lt(Arel::Nodes::BindParam.new), {attribute => value})
    end

    def where_in(attribute, values)
      bind_params = values.map{ Arel::Nodes::BindParam.new }
      column_values = values.each_with_object([]) { |value, column_values| column_values.push [attribute, value] }
      where_with_bind(arel_table[attribute].in(bind_params), column_values)
    end

    def where_with_bind(clause, opt)
      where(clause).bind_parameters(opt)
    end

  end
end
