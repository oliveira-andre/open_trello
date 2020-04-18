# frozen_string_literal: true

class Tag < ApplicationRecord
  enum color: { ffffff: 0, '00ffff': 1 }

  belongs_to :task

  validates :description, :task_id, :color, presence: true
end
