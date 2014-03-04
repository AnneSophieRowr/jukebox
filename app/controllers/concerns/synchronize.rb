module Concerns
  module Synchronize
    extend ActiveSupport::Concern

    def synchronize
      results = controller_name.classify.constantize.updated(params[:date])
      render json: results.to_json
    end

  end
end
