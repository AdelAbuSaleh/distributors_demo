# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ProvidersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/providers').to route_to('v1/providers#index')
    end

    it 'routes to #new' do
      expect(get: '/v1/providers/new').to route_to('v1/providers#new')
    end

    it 'routes to #show' do
      expect(get: '/v1/providers/1').to route_to('v1/providers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/v1/providers/1/edit').to route_to('v1/providers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/providers').to route_to('v1/providers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/providers/1').to route_to('v1/providers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/providers/1').to route_to('v1/providers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/providers/1').to route_to('v1/providers#destroy', id: '1')
    end
  end
end
