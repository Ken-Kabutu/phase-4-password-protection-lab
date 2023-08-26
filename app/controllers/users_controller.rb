class UsersController < ApplicationController
    
    
    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.user_id
            render json: user, status: :created
        else 
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private 
    
    def user_params
        params.require(:user).permit(:username, :password)
    end


    def show 
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user
        else
            head :unauthorized
        end
    end
end
