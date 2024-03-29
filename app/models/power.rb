# frozen_string_literal: true

class Power
  include Consul::Power

  def initialize(current_user, current_orgnaization)
    @current_user = current_user
    @current_orgnaization = current_orgnaization
  end

  def user?
    @current_user.present?
  end

  def provider?
    return unless @current_user.try(:orgnaization).nil?

    @current_user
  end

  # get the role form current users
  def role
    return if user?.blank? || provider?

    @current_user.role.to_s
  end

  def super_admin?
    true if role.eql?('super_admin')
  end

  def admin?
    true if role.eql?('admin')
  end

  def employee?
    true if role.eql?('employee')
  end

  # Generate powers for all tables and by default prevent them all from access
  ActiveRecord::Base.connection.tables.map(&:to_sym) - %i[schema_migrations ar_internal_metadata].each do |model|
    power model do
      false
    end
  end

  ######################## V1::StaticPagesController #######################
  power :static_pages do
    true
  end

  ######################## V1::UsersController #######################

  power :users_index do
    return User.all if super_admin?
    return @current_orgnaization.users if admin?

    powerless!
  end

  power :users_show do
    return User if super_admin?
    return @current_orgnaization.users if admin?

    powerless!
  end

  power :creatable_users do
    return User if super_admin? || admin?

    powerless!
  end

  power :updatable_users do
    return User if super_admin?

    powerless!
  end

  power :destroyable_users do
    return User if super_admin?

    powerless!
  end

  ######################## V1::OrgnaizationsController #######################

  power :orgnaizations_index do
    return Orgnaization.all if super_admin?
    return @current_user.orgnaizations if admin?

    powerless!
  end

  power :orgnaizations_show do
    return Orgnaization.all if super_admin?
    return @current_user.orgnaizations if admin?

    powerless!
  end

  power :creatable_orgnaizations do
    return Orgnaization if super_admin?

    powerless!
  end

  power :updatable_orgnaizations do
    return Orgnaization if super_admin?

    powerless!
  end

  power :destroyable_orgnaizations do
    powerless!
  end

  ######################## V1::SessionsController #######################

  power :sessions do
    true
  end

  ######################## V1::RequestController #######################

  power :requests_index, :request_show do
    return @current_orgnaization.requests if admin?
    return @current_user.requests if employee?
    return @current_user.requests if provider?

    powerless!
  end

  power :creatable_request do
    return Request if admin? || employee?

    powerless!
  end

  power :updatable_request do
    return Request if admin? || employee? || provider?

    powerless!
  end

  power :destroyable_request do
    return Request if admin? || employee?

    powerless!
  end

  ######################## V1::ProviderOperationsController ####################

  power :provider_operations_index, :provider_operations_show do
    return @current_user&.provider_operations if provider?
    return @current_orgnaization&.provider_operations if admin? || employee?

    # return ProviderOperation if super_admin?
    powerless!
  end

  power :creatable_provider_operations, :updatable_provider_operations, :destroyable_provider_operations do
    return ProviderOperation if provider?

    powerless!
  end

  ######################## V1::ProvidersController #######################

  power :providers_index, :providers_show, :creatable_providers, :updatable_providers, :destroyable_providers do
    return Provider if super_admin?

    powerless!
  end
end
