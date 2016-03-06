class Task < ActiveRecord::Base

  before_create :set_default_status

  private
    def set_default_status
      self.status = "Open"
    end

end
