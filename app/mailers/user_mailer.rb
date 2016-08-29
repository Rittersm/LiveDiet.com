class UserMailer < ApplicationMailer

  def signup_email(user)
    @user = user
    mail( :to => @user.email, :subject => 'Welcome to LiveDiet' )
  end

  def checkin_reminder(user)
    @user = user
    mail( :to => @user.email, :subject => "Reminder of upcoming Check In")
  end

end
