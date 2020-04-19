# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :load_user
      before_action :load_projects, only: :index

      def index
        success_response(data: @projects, model: 'Project')
      end

      private

      def load_projects
        @projects = @user.projects.active
      end
    end
  end
end
