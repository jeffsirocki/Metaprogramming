class Product < ApplicationRecord
  ACTIONS = %i[sell return refund]

  ACTIONS.each_with_index do |action, i|
    define_method(action) do
      self.decrement!(:stock) if i.zero?
      self.increment!(:stock) if i == 1
      puts "#{action.capitalize} 1 product"
    end
  end

  def process(action)
    return unless self.respond_to?(action)

    item.send(action)
  end
end
