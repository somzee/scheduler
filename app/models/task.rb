class Task < ActiveRecord::Base

  belongs_to :user

  validates :name, :user_id, presence: true
  before_save :set_defaults

  private

  def set_defaults
    self.status ||= "Open"
    self.due_date ||= Date.today
  end

end
