class Task < ActiveRecord::Base

  validates :name, presence: true
  before_create :set_defaults
  before_update do 
  	self.due_date = Date.today if self.due_date.nil?
  end

  private
    def set_defaults
      self.status = "Open"
      self.due_date ||= Date.today
    end

end
