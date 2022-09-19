class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_creditials(params[:user][:username], params[:user][:password])
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            redirect_to new_user_url
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
