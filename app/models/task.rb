class Task < ActiveRecord::Base

  before_create :set_defaults

  private
    def set_defaults
      self.status = "Open"
      self.due_date ||= Date.today
    end

end
