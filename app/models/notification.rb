class Notification < ApplicationRecord
  before_save :default_values

  def default_values
    self.seen = false if self.seen.nil?
  end
end
