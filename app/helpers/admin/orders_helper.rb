module Admin::OrdersHelper
  def tab_by_location(orders,location)
    ret = ''
    orders.each do |order|
      if order.location.name == location.name
        ret += order.user.given_name + " " + order.user.family_name
        ret += order.delivered_at.strftime("%a, %d. %b")
        ret += order.created_at.strftime("%a, %d. %b")
      end
    end
    ret
  end
end
