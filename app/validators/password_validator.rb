class PasswordValidator < ActiveModel::Validator
  def validate record
    return if record.password.blank? || record.password =~ ApplicationRecord::VALID_PASSWORD_REGEX
    record.errors.add :password, I18n.t("validation.password.format_invalid")
  end
end
