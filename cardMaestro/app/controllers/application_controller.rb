class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: :index
    before_action :reset_flash

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:city])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:province])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:country])
    end


    def reset_flash
        flash = nil
    end
end
