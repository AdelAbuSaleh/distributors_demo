# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Users', type: :request do
  describe 'GET /v1/users' do
    it 'works! (now write some real specs)' do
      get v1_users_path
      expect(response).to have_http_status(200)
    end
  end
end
