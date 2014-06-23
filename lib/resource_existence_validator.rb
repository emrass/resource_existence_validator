require 'active_model'

class ResourceExistenceValidator < ActiveModel::EachValidator
  @@default_options = {}

  def self.default_options
    @@default_options
  end

  def validate_each(record, attribute, value)
    options = @@default_options.merge(self.options)

    if value.nil?
      if options[:allow_nil]
        return
      else
        record.errors.add(attribute, options[:message] || :is_nil)
      end
    end

    begin
      if !options[:class_name]
        klass = attribute.to_s.chomp("_id").capitalize.constantize
      else
        klass = options[:class_name].to_s.capitalize.constantize
      end

      if !klass.exists?(id: value)
        record.errors.add(attribute, options[:message] || :invalid)
      end
    rescue NameError => e
      record.errors.add(attribute, :klass_error )
    end
  end
end
