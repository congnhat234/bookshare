module ApplicationHelper
  def flash_class level
    case level
    when "notice", "success" then "alert-success"
    when "error" then "alert-error"
    when "alert", "danger" then "alert-danger"
    when "warning" then "alert-warning"
    when "info" then "alert-info"
    end
  end

  def flash_message action, model, is_valid = true
    state = is_valid ? "success" : "fail"
    I18n.t "flash.messages.#{action}.#{state}",
      model_name: I18n.t("flash.models.#{model.model_name.param_key}").capitalize
  end

  def number_to_currency_format number
    if /\A[-+]?\d+\z/.match?(number.to_s) || /\A[+-]?(\d+\.\d+)?\Z/.match?(number.to_s)
      Money.new(number.to_f.round(3), "VND").format
    else
      number
    end
  end

  def full_title page_title = ""
    base_title = I18n.t "helpers.base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def user_meta_data
    {
      id: current_user.id,
      name: current_user.name,
      session_timeout: current_user.timeout_in
    }
  end
end
