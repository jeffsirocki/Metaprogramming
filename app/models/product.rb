class Product < ApplicationRecord
  ACTIONS = %i[sell return refund]

  ACTIONS.each_with_index do |action, i|
    define_method(action) do
      self.decrement!(:stock) if i.zero?
      self.increment!(:stock) if action = "return"
      puts "#{action.capitalize} 1 product"
    end
  end

  def process(action)
    return unless self.respond_to?(action)

    item.send(action)
  end

  def method_missing(method_name, *args)
    if method_name.ends_with?("?")
      result = self.send(method_name.chop, *args)
      result.present? && result != 0
    else
      super
    end
  end
end
