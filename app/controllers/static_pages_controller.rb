# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :validate_token!
  # skip_power_check
  power :static_pages

  def home; end

  def help; end

  def about; end

  def contact; end
end
