class ApplicationController < ActionController::API

  def render_400
    head :bad_request
  end

  def render_404
    head :not_found
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
