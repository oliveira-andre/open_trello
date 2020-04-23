# frozen_string_literal: true

module Api
  module V1
    class ListsController < ApplicationController
      before_action :load_user
      before_action :load_project
      before_action :load_lists, only: :index

      def index
        success_response(data: @lists, model: 'List')
      end

      def create
        @list = List.new(project: @project)
        if @list.save
          success_response(data: @list, model: 'List', status: :created)
        else
          error_response
        end
      end

      private

      def load_project
        @project = @user.projects.find_by(title: params.dig(:project_title))
      end

      def load_lists
        @lists = @project.lists.active
      end
    end
  end
end
