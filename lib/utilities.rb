module Utilities
  def present?(obj)
    !blank?(obj)
  end

  def blank?(obj)
    obj.nil? || obj == false || obj.empty? || obj =~ /^\s+$/
  end
end