# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :load_user
      before_action :load_list, :load_task

      def update
        if @task.update(task_params)
          success_response(data: @task, model: 'Task')
        else
          error_response
        end
      end

      private

      def task_params
        params.require(:tasks).permit(:title, :description, :status, :list_id)
      end

      def load_list
        @list = List.find(params.dig(:list_id))
      end

      def load_task
        @task = Task.find(params.dig(:id))
      end
    end
  end
end
