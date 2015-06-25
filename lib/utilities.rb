module Utilities
  def present?(obj)
    !blank?(obj)
  end

  def blank?(obj)
    obj.nil? || obj == false || obj.empty? || obj =~ /^\s+$/
  end

  def stringify(options)
    options.map {|key, val| "#{key}=#{val}"}.join('&') if options.respond_to? :map
  end
end