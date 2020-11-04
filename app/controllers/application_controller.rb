class ApplicationController < ActionController::API
  include ExceptionHandler
  include JsonResponseHandler
  include JwtToken
end
