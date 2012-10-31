@orders.each do |order|

pdf.text "Order ##{order.deliver_to}", :size => 30, :style => :bold

pdf.move_down(30)

items = order.meals.map do |item|
  [
    item.meal_type.title,
    item.amount
  ]
end

pdf.table items, :border_style => :grid,
  :row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["Meal", "Qty"],
  :align => { 0 => :left, 1 => :right }

pdf.move_down(10)

pdf.text "Total #{order.total_order_amount}", :size => 16, :style => :bold

start_new_page

end
