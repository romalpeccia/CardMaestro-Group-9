class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: :index
    before_action :reset_flash


    def reset_flash
        flash = nil
    end
end
