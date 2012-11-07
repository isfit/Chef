class OrderPdf < Prawn::Document
  def initialize(orders, meal_types, date)
    super(top_margin: 70)
    @orders = orders
    @meal_types = meal_types
    @date = date
    generate_orders
  end

  def generate_orders


    text "Overview for  ##{@date}", :size => 30, :style => :bold

    move_down(30)

    overview =  [["Meal", "Qty"]] + @meal_types
    table overview

    start_new_page

    @orders.each do |order|

      text "Order #{order.deliver_to}", :size => 30, :style => :bold

      move_down(30)

      items = [["Meal", "Qty"]] +
        order.meals.map do |item|
        [
          item.meal_type.title,
          item.amount
        ]
        end

      table items

      move_down(10)

      text "Total #{order.total_order_amount}", :size => 16, :style => :bold

      start_new_page

    end
  end

end
