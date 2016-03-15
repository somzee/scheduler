class Task < ActiveRecord::Base

  belongs_to :user

  STATUSES = {
    done: "Done",
    open: "Open",
  }

  validates :name, :user_id, presence: true
  before_save :set_defaults

  # owner scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }

  # status scopes
  scope :open, -> { by_status(STATUSES[:open]) }
  scope :done, -> { by_status(STATUSES[:done]) }
  scope :by_status, -> (status) { where(status: status) }

  # due date scopes
  scope :past, -> { where("due_date < ?", Date.today) }
  scope :due_today, -> { where("due_date = ?", Date.today) }
  scope :future, -> { where("due_date > ?", Date.today) }

  # sort scopes
  scope :sorted, -> { order(:due_date) }

  private

  def set_defaults
    self.status ||= "Open"
    self.due_date ||= Date.today
  end

end
