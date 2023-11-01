class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def not_found_response(error)
    render json: ErrorSerializer.serialize(error), status: :not_found
  end
end
