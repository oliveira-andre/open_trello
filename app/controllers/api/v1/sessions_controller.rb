# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      before_action :load_user, only: :create

      def create
        if @user.valid?
          success_response(data: @user, model: 'Session', status: :created)
        else
          error_response
        end
      end

      private

      def valid?
        @user.valid_password?(session_params.dig(:password))
      end

      def session_params
        params.require(:users).permit(:email, :password)
      end

      def load_user
        @user = User.find_by(email: session_params.dig(:email))
      end
    end
  end
end
