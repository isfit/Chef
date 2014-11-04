class Admin::OrdersController < ApplicationController
  before_filter :admin_required

  def index
    redirect_to admin_order_path("2015-02-05")
  end

  def show
    @orders = Order.to_be_delivered_on(Date.parse(params[:id]))

    @total = 0
    @meal_types = MealType.all.map do |m|
      tot = m.amount_ordered_for_day(Date.parse(params[:id]))
      @total += tot
      [m.title, tot]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do 
        pdf = OrderPdf.new(@orders, @meal_types, params[:id], @total)
        send_data pdf.render, filename:"orders",type: "application/pdf",
          disposition: "inline"
      end
    end
  end

end
