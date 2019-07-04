# frozen_string_literal: true

module Api
  module V1
    # Controller for control index
    class ControlController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_user

      # Control Index: here getting a employees list
      # and the admin will can check in or check out
      # a employee
      def index
        message('Ready')
      end

      private

      def authorize_user
        authorize :control, :index?
      end
    end
  end
end
