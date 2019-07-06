# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OperationsController, type: :controller do
  let(:user) { create(user_assigned) }

  context 'without an authenticated user' do
    let(:user_assigned) { :administrator }

    describe 'GET /api/v1/operations' do
      it '401 - Unauthorized' do
        get :index
        expect(response.status).to eq(401)
      end
    end

    describe 'POST /api/v1/operations/check' do
      it '401 - Unauthorized' do
        post :check
        expect(response.status).to eq(401)
      end
    end
  end

  context 'with an authenticated user' do
    let(:user_assigned) { :administrator }
    before { sign_in(user) }

    describe 'GET /api/v1/operations' do
      before do
        mock = double(index?: true)

        expect(OperationPolicy)
          .to receive(:new)
          .with(user: user)
          .once
          .and_return(mock)
      end

      it '200 - OK' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    describe 'POST /api/v1/operations/check' do
      let(:user_assigned) { :administrator }
      let(:employee) { create(:employee) }

      before do
        mock = double(check?: true)

        expect(OperationPolicy)
          .to receive(:new)
          .with(user: user)
          .once
          .and_return(mock)
      end

      before do
        post :check, params: {
          operation: {
            employee_id: employee.id,
            note: 'Note here'
          }
        }
      end

      it '200 - OK' do
        expect(response.status).to eq(200)
      end
    end
  end
end
