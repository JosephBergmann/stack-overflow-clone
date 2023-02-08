class Api::SessionsController < ApplicationController
    before_action :require_logged_out, only: [:create]
    before_action :require_logged_in, only: [:destroy]

    def show
        @user = current_user
        if @user
            render 'api/users/show'
        else
            render json: { user: nil }
        end
    end

    def create
        username = params[:email]
        password = params[:password]
        @user = User.find_by_credentials(username, password)
        if @user
            login(@user)
            render 'api/users/show'
        else
            render json: { errors: ['Invalid credentials'] }, status: 422
        end
    end

    def destroy
        logout
        debugger
        # head :no_content 
        # populate http response with no content => no body
        # render json: {test: ['Logged out successfully']}, status: :ok
        render json: { message: 'success' }
    end
end
