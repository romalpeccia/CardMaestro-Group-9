class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :reset_flash


    def reset_flash
        flash = nil
    end
end
