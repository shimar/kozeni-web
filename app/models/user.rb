class User < ActiveRecord::Base
  # associations.
  has_many :categories
  has_many :incomes
  has_many :outgoes

  authenticates_with_sorcery!

  validates :email,
            presence: true,
            uniqueness: true

  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password,
            confirmation: true,
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

end
