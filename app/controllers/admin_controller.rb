class AdminController < ApplicationController

  def orders
    if params[:date].nil? 
      params[:date] = "2012-10-29" 
    end

    @orders = Order.to_be_delivered_on(Date.parse(params[:date]))

    @meal_types = MealType.all.map do |m|
      [m.title, m.amount_ordered_for_day(Date.parse(params[:date]))]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do 
        pdf = OrderPdf.new(@orders, @meal_types, params[:date])
        send_data pdf.render, filename:"orders",type: "application/pdf",
          disposition: "inline"
      end
    end
  end

  def production_amount

  end

end
