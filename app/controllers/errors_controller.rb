class ErrorsController < ApplicationController
  skip_before_filter :authenticate_admin!

  def not_found
    render(:status => 404)
  end

  def server_error
    if Rails.application.config.github_url.present?
      @github_url = Rails.application.config.github_url + "/issues/new"
    end
    render(:status => 500)
  end

  def request_too_large
    render(:status => 413)
  end

end
