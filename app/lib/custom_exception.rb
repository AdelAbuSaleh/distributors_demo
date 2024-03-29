# frozen_string_literal: true

module CustomException
  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthUserNotFound < StandardError; end
  class ExpiredSignature < StandardError; end
  class MissingToken < StandardError; end
  # class UserDeleteError < StandardError; end
  # class ProviderDeleteError < StandardError; end
end
