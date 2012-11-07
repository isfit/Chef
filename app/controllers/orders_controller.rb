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
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def new_mass_order
    @order = Order.new
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create_mass_order
    @order = Order.new(params[:order])
    @order.user = current_user
    @order.delivered_at = Date.parse("2013-02-07")

    date = Date.parse("2013-02-07")
    10.times do
      o = Order.new
      o.deliver_to = @order.deliver_to
      date = date+1
      o.delivered_at = date
      o.user = @order.user
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
    @order = current_user.orders.find(params[:id])
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.user = current_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = current_user.orders.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
