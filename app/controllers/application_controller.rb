class ApplicationController < ActionController::API
  include ExceptionHandler
  include JsonResponseHandler
  include JwtToken
  include Authenticatable
  serialization_scope :view_context
  before_action :current_user
end
