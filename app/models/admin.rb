class Admin < ApplicationRecord
  belongs_to :user
  before_destroy :ensure_one_admin
  validate :admin_count_within_limit, :on => :create

  def ensure_one_admin
    errors.add(:base, "Cannot delete admin")
    throw :abort
  end

  def admin_count_within_limit
    if Admin.count >= 1
      errors.add(:base, "Exceeded limit")
    end
  end
end
