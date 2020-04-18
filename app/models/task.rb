# frozen_string_literal: true

class Task < ApplicationRecord
  enum status: { active: 0, archived: 1 }

  has_many :tags
  has_many :comments
  has_one_attached :cover

  belongs_to :list
  belongs_to :responsable_id, class_name: 'User', foreign_key: 'user_id'

  validates :title, :status, :list_id, presence: true
end
