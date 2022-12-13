class UsersController < ApplicationController
    skip_before_action :authorize, only: [:create, :show]
  before_action :authorize_admin, only: [:create, :destroy]
  
    def show_me
      render json: current_user, status: :accepted
    end

    def show
      user = User.find_by!(id: params[:id])
      render json:  user, status: 200
    end
  
    def create
      @user = User.create!(user_params)
       if @user.valid?
        @token = encode_token({ user_id: @user.id })
        render json: { user: @user, jwt: @token }, status: :created
      # else
      #   render json: { error: 'failed to create user' }, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    end
  
    private
  
    def user_params
      params.permit(:email, :full_name, :msidn,:location, :user_type, :password, :password_confirmation, :user_type)
    end
end
