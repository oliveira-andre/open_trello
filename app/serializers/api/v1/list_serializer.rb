# frozen_string_literal: true

module Api
  module V1
    class ListSerializer < ActiveModel::Serializer
      attributes :id, :title

      has_many :tasks, if: -> { object.tasks.present? }
    end
  end
end
