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
    # if /\A[-+]?\d+\z/.match?(number.to_s) || /\A[+-]?(\d+\.\d+)?\Z/.match?(number.to_s)
    #   Money.new(number.to_f.round(3), @company.currency).format
    # else
    #   number
    # end
  end

  def full_title page_title = ""
    # company_name = @company.name
    # return company_name if page_title.empty?
    # company_name + " | " + page_title
  end
end
