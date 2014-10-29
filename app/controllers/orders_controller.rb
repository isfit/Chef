class OrdersController < ApplicationController
  before_filter :login_required
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = find_order(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.meals << Meal.new
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
  end

  def new_mass_order
    @order = Order.new
    @order.meals << Meal.new
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create_mass_order
    @order = Order.new(params[:order])
    @order.user = current_user
    @order.delivered_at = DateTime.parse("2013-02-07 12:00")

    dates = ["2013-02-08 12:00",
      "2013-02-09 12:00",
      "2013-02-10 12:00",
      "2013-02-12 12:00",
      "2013-02-14 12:00",
      "2013-02-16 12:00",
      "2013-02-17 12:00"]
    dates.each do |date_string|
      o = Order.new
      o.deliver_to = @order.deliver_to
      o.delivered_at = DateTime.parse(date_string)
      o.user = @order.user
      o.comment = @order.comment
      @order.meals.each do |m|
        a = Meal.new
        a.amount = m.amount
        a.meal_type_id = m.meal_type_id
        o.meals << a
      end
      o.save
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /orders/1/edit
  def edit
    @order = find_order(params[:id])
    params[:date] = @order.delivered_at
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
  end

  # POST /orders
  def create
    @order = Order.new(params[:order])
    @order.user = current_user
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :action => 'new'
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = find_order(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to action: "edit", error: "Ugyldige endringer"  }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = find_order(params[:id])
    date = @order.delivered_at.strftime("%Y-%m-%d")
    @order.destroy

    respond_to do |format|
      format.html { redirect_to current_user.admin? ? admin_order_path(date) : orders_url }
      format.json { head :no_content }
    end
  end

  def find_order(order_id)
    if current_user.admin?
      Order.find(params[:id])
    else
      current_user.orders.find(params[:id])
    end
  end
end
