class OrderPdf < Prawn::Document
  def initialize(orders, meal_types, date, total, location)
    super(left_margin: 70, right_margin: 70, top_margin:50, bottom_margin:20, page_size: "A4")
    if(location.nil?)
      @orders = orders
    else
      @orders = []
      @total = 0
      orders.each do |order|
        if order.location.name == location
          @orders << order
        end
      end
    end

    @meal_types = meal_types
    @date = Date.parse(date).strftime("%a, %d. %b")
    @total = total
    generate_orders(location)
  end

  def generate_orders(location)
    if location.nil?
      text "Oversikt for #{@date} til alle destinasjoner", :size => 30, :style => :bold
    else
      text "Oversikt for #{@date} til #{location}", :size => 30, :style => :bold
    end


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
      text "Bestilling ##{order.id} - #{page_number.to_s}/#{@orders.count.to_s}", :size => 16, :style => :italic, align: :right

      move_down(40)

      text "Leveres til:", :style => :italic
      text order.user.given_name + " " + order.user.family_name, :size=>18, :style => :bold
      begin #using begin here since this might be unreliable
      text order.user.positions[0].groups[0].name_no, :size=>18, :style => :bold
      rescue
      end
      if !order.location.address.nil?
        text order.location.name, :size=>18, :style => :bold
        text order.location.address, :size=>18, :style => :bold
      end
      if !order.workshop_name.nil?
         text order.workshop_name, :size=>18, :style => :italic
      end
      if !order.deliver_to.nil?
        text order.deliver_to, :size=>18, :style => :bold
      end

      text "Tlf: #{order.user.phone}", :size=>18, :style => :italic

      text_box "Leveringstidspunkt:", 
        :at => [350,714],
        :height => 200,
        :width => 200,
        :style => :italic

      text_box order.delivered_at.strftime("%a, %d. %b"),
        :at => [350,700],
        :size=>18, :style => :bold,
        :height => 200,
        :width => 200

      text_box order.delivered_at.strftime("%H:%M"),
        :at => [350,670],
        :size=>30, :style => :bold,
        :height => 200,
        :width => 200

    horizontal_line 0, 450, :at => 570
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

      move_down(20)
      text "Kommentar:\n #{order.comment}", :size => 12, :align => :left

      image "#{Rails.root}/app/assets/images/isfit_logo2015.png", :scale => 0.5, :at => [0,110]
      text_box "Velferd: board.hospitality@isfit.org\nKatrine Listau: 957 59 755", :at => [300,30], :size => 10
      text_box "Transport: transport@isfit.org\nKenneth Eggan: 473 33 637", :at => [0,30], :size => 10

    end
  end
end
