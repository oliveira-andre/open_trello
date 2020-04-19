# frozen_string_literal: true

class Project < ApplicationRecord
  enum status: { active: 0, archived: 1 }

  has_one_attached :cover
  has_many :lists

  belongs_to :user

  validates :title, :status, :user_id, presence: true
  validates :title, uniqueness: { scope: :user_id }
end
