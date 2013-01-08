class OrderPdf < Prawn::Document
  def initialize(orders, meal_types, date, total)
    super(margin: 70, page_size: "A4")
    @orders = orders
    @meal_types = meal_types
    @date = Date.parse(date).strftime("%a, %d. %b")
    @total = total
    generate_orders
  end

  def generate_orders
    text "Oversikt for #{@date}", :size => 30, :style => :bold

    move_down(30)

    text "#{@total} enheter fordelt paa #{@orders.count} bestillinger", :size=>16, :style => :bold

    move_down(30)


    overview =  [["Maaltid", "Antall"]] + @meal_types
    table(overview, :column_widths => {0 => 400, 1=> 50})

    page_number = 0

    @orders.each do |order|
      start_new_page
      page_number+=1

      details = [["Leveres til:", "Leveringstidspunkt"], [order.deliver_to, order.delivered_at]]

      text_box "#{order.total_order_amount} enheter", :size => 18, :style => :bold, align: :left
      text "Bestilling ##{order.id}", :size => 16, :style => :italic, align: :right

      move_down(40)

      text "Leveres til:", :style => :italic
      text order.user.given_name + " " + order.user.family_name, :size=>18, :style => :bold
      text order.deliver_to, :size=>18, :style => :bold
      text "Tlf: #{order.user.phone}", :size=>18, :style => :italic

      text_box "Leveringstidspunkt:", 
        :at => [350,645],
        :height => 200,
        :width => 200,
        :style => :italic

      text_box order.delivered_at.strftime("%a, %d. %b"),
        :at => [350,630],
        :size=>18, :style => :bold,
        :height => 200,
        :width => 200

      text_box order.delivered_at.strftime("%H:%M"),
        :at => [350,600],
        :size=>30, :style => :bold,
        :height => 200,
        :width => 200

    horizontal_line 0, 450, :at => 500
      move_down(100)

      items = [["Maaltid", "Antall"]] +
        order.meals.map do |item|
        [
          item.meal_type.title,
          item.amount
        ]
        end

      table(items, 
          :column_widths => {0 => 400, 1=> 50})

      move_down(20)

      text "Total #{order.total_order_amount}", :size => 16, :style => :bold, :align => :right

      text_box page_number.to_s + "/" + @orders.count.to_s, :at => [430, 20], :size => 16
    end
  end
end
