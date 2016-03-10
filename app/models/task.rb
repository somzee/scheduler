class Task < ActiveRecord::Base

  validates :name, presence: true
  before_create :set_defaults
  before_update :set_defaults

  private
    def set_defaults
      self.status = "Open"
      self.due_date ||= Date.today
    end

end
