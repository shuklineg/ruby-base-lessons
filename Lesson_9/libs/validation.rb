module Validation
  EmpytValue = Class.new(StandardError)
  WrongFormat = Class.new(StandardError)
  WrongType = Class.new(StandardError)

  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def validates(name, type, option = nil)
      raise TypeError unless name.is_a?(Symbol)
      raise TypeError unless type.is_a?(Symbol)
      raise TypeError if type == :format && !option.is_a?(Regexp)
      raise TypeError if type == :type && !option.is_a?(Class)

      @validators ||= {}
      var_name = "@#{name}".to_sym
      @validators["#{var_name}_#{type}"] = {
        name: var_name, type: type, option: option
      }
    end
  end
  module InstanceMethods
    def validate!
      validators = self.class.instance_variable_get(:@validators)
      validators.each do |_key, validator|
        value = instance_variable_get(validator[:name])
        case validator[:type]
        when :presence
          validate_presence(value)
        when :type
          validate_type(value, validator[:option])
        when :format
          validate_format(value, validator[:option])
        end
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    def validate_presence(value)
      raise Validation::EmpytValue if value.nil? || value == ''
    end

    def validate_type(value, type)
      raise Validation::WrongType unless value.is_a? type
    end

    def validate_format(value, regex)
      raise Validation::WrongFormat if value !~ regex
    end
  end
end
