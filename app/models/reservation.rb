class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :people, presence: true, numericality: { greater_than: 0 }

  validate :check_in_before_check_out
  validate :check_in_not_before_today

  private

  def check_in_before_check_out
    if check_in.present? && check_out.present? && check_in >= check_out
      errors.add(:check_out, :must_be_after_check_in)
    end
  end

  def check_in_not_before_today
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, :must_be_today_or_later)
    end
  end
end
