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
    @locations = Location.all.collect {|p| [ p.name, p.id ] }
  end

  def new_mass_order
    @order = Order.new
    @order.meals << Meal.new
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
    @locations = Location.all.collect {|p| [ p.name, p.id ] }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create_mass_order
    @order = Order.new(params[:order])
    @order.user = current_user
    dates = Rails.application.config.workshop_dates
    @order.delivered_at = DateTime.parse(dates[0])
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
    @locations = Location.all.collect {|p| [ p.name, p.id ] }
    orders_saved = false

    dates.each do |date_string|
      o = Order.new
      o.deliver_to = @order.deliver_to
      o.location = @order.location
      o.delivered_at = DateTime.parse(date_string)
      o.user = @order.user
      o.comment = @order.comment
      @order.meals.each do |m|
        a = Meal.new
        a.amount = m.amount
        a.meal_type_id = m.meal_type_id
        o.meals << a
      end
      if o.save
        orders_saved = true
      else
        orders_saved = false
        @order.errors[:base] << "Ett av feltene inneholder ugyldig data"
        break
      end
    end

      if orders_saved
        redirect_to orders_path, notice: 'Ordrer opprettet'
      else
        render action: "new_mass_order"
      end
  end

  # GET /orders/1/edit
  def edit
    @order = find_order(params[:id])
    params[:date] = @order.delivered_at
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
    @locations = Location.all.collect {|p| [ p.name, p.id ] }
  end

  # POST /orders
  def create
    if(params[:date].blank?)
      @order = Order.new(params[:order])
      @order.user = current_user
      @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
      @locations = Location.all.collect {|p| [ p.name, p.id ] }
      @order.errors[:base] << "Ugyldig dato"
      render :action => 'new'
      return
    end
    date = DateTime.parse(params[:date])
    params[:order]["delivered_at(1i)"] = date.year.to_s
    params[:order]["delivered_at(2i)"] = date.mon.to_s
    params[:order]["delivered_at(3i)"] = date.mday.to_s
    params[:order]["delivered_at(4i)"] = '12' ##Remove to restore time functionality
    params[:order]["delivered_at(5i)"] = '00' ##Remove to restore time functionality
    @order = Order.new(params[:order])
    @order.user = current_user
    @meal_types = MealType.all.collect {|p| [ p.title, p.id ] }
    @locations = Location.all.collect {|p| [ p.name, p.id ] }

    if @order.save
      redirect_to @order, notice: 'Ordre ble opprettet.'
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
        format.html { redirect_to @order, notice: 'Ordre ble oppdatert.' }
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
      format.html { redirect_to orders_url, notice: 'Ordre ble slettet' }
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
