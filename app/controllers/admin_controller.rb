class AdminController < ApplicationController

  def orders
    if params[:date].nil? 
      params[:date] = "2012-10-29" 
    end
    @orders = Order.to_be_delivered_on(Date.parse(params[:date]))

    respond_to do |format|
      format.html # show.html.erb
      format.pdf { render :layout => false }
    end
  end

  def production_amount

  end

end
