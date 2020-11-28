module Authenticatable
  def current_user
    @current_user = AuthorizeApiRequest.new(request.headers['Authorization']).current_user
  end

  def authorize_request
    PermissionRequest.new(current_user, controller_name, params['action'])
  end
end
