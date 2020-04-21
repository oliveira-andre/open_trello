# frozen_string_literal: true

module Api
  module V1
    class TaskSerializer < ActiveModel::Serializer
      attributes :id, :title, :description, :schedule_date
    end
  end
end
