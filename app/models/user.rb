class User < ApplicationRecord
  has_secure_password
  has_one :admin
  has_many :tickets , dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, presence: true, on: :create
  validate :protect_admin_fields, on: :update
  validates :credit_card_number, allow_blank: true, format: { with: /\b(?:\d[ -]*?){13,16}\b/ , message: "should be between 13 and 16 numeric digits" }
  validates :phone_number, allow_blank: true, format: { with: /\A\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*\z/, message: "should be 10 digits with optional country code"}
  before_destroy :ensure_not_admin
  has_many :reviews, dependent: :destroy
  has_many :purchased_tickets, class_name: 'Ticket' , dependent: :destroy
  has_many :received_tickets, class_name: 'Ticket', foreign_key: 'purchased_for_user_id' , dependent: :destroy

  def admin?
    admin.present?
  end

  private
  def protect_admin_fields
    if admin?
      password = nil
    end
    if admin? && (email_changed?)
      errors.add(:email, "Admin accounts cannot change email and password")
    end
  end

  def ensure_not_admin
    if admin?
      raise ActiveRecord::RecordNotDestroyed.new("Cannot delete Admin")
    end
  end
end
