module ActiverecordExtensions
  module QueryBuilder

    def where_gt(attribute, value)
      where_with_bind(arel_table[attribute].gt(Arel::Nodes::BindParam.new), attribute, value)
    end

    def where_lt(attribute, value)
      where_with_bind(arel_table[attribute].lt(Arel::Nodes::BindParam.new), attribute, value)
    end

    private
      def where_with_bind(clause, attribute, value)
        where(clause).bind_parameters({attribute => value})
      end

  end
end
