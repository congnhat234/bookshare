class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+[0-9a-z]@[a-z\d\-.]+[a-z]\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[[:alnum:][:space:]-]*\z/
  VALID_PASSWORD_REGEX = /(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W])/
  VALID_PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/

  def generate_random_password # rubocop:disable Metrics/AbcSize
    password = Devise.friendly_token(Settings.password.token_number).split Settings.password.splitter
    password.push Settings.password.small_letter_array.sample
    password.push Settings.password.capital_letter_array.sample
    password.push Settings.password.number_array.sample
    password.push Settings.password.special_character_array.sample
    password.shuffle.join
  end
end
