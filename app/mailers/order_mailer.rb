class OrderMailer < ApplicationMailer
  add_template_helper MailerHelper
  def order_complete user, order, titles
    @user = user
    @order = order
    @titles = titles
    mail to: user.email
  end

  def order_cancel user, order, titles
    @user = user
    @order = order
    @titles = titles
    mail to: user.email
  end

  def order_done user, order, titles
    @user = user
    @order = order
    @titles = titles
    mail to: user.email
  end
end
