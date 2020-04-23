# frozen_string_literal: true

class List < ApplicationRecord
  enum status: { active: 0, archived: 1 }

  has_many :tasks

  belongs_to :project

  validates :status, :project_id, presence: true
end
