# frozen_string_literal: true

class Coment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :description, :task_id, :color, presence: true
end
