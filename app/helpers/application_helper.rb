module ApplicationHelper

  def selected?(x)
    if current_user.current_subscription.rating
      if current_user.current_subscription.rating.value == x
         "selected"
      end
    end
  end

end
