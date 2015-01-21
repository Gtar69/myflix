class AddOrderToQueueItem < ActiveRecord::Migration
  def change
    add_column :queue_items, :order, :integer
  end
end
