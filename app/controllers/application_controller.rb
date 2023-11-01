class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def not_found_response(error)
    render json: ErrorSerializer.serialize(error), status: :not_found
  end

  def invalid_response(error)
    render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
  end
end
