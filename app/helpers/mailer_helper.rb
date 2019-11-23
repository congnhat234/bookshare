module MailerHelper
  def number_to_currency_format number
    if /\A[-+]?\d+\z/.match?(number.to_s) || /\A[+-]?(\d+\.\d+)?\Z/.match?(number.to_s)
      Money.new(number.to_f.round(3), "VND").format
    else
      number
    end
  end
end
