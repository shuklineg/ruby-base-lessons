module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        raise TypeError unless name.is_a?(Symbol)

        var_name = "@#{name}".to_sym
        history_method = "#{name}_history".to_sym
        history_var = "#{var_name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          history = send(history_method)
          history << value unless history.last == value
        end
        define_method(history_method) do
          instance_variable_get(history_var) ||
            instance_variable_set(history_var, [])
        end
      end
    end

    def strong_attr_accessor(name, var_class)
      raise TypeError unless name.is_a?(Symbol)
      raise TypeError unless var_class.is_a?(Class)

      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError unless value.is_a? var_class

        instance_variable_set(var_name, value)
      end
    end
  end
end
