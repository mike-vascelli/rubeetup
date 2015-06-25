module Utilities
  def present?(obj)
    !blank?(obj)
  end

  def blank?(obj)
    obj.nil? || obj == false || obj.empty? || obj =~ /^\s+$/
  end

  def stringify(options)
    return unless options.respond_to? :map
    options.map { |key, val| "#{key}=#{val}" }.join('&')
  end
end
