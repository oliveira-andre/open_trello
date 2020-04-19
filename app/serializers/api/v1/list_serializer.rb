module Api
  module V1
    class ListSerializer < ActiveModel::Serializer
      attributes :title
    end
  end
end
