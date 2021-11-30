class GymsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        gyms = Gym.all 
        render json: gyms
    end

    def show 
        gym = find_gym
        render json: gym
    end

    def update 
        gym = find_gym
        if gym.update(gym_params)
            render json: gym, status: :accepted 
        else 
            render json: {error: gym.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    def destroy 
        gym = find_gym
        gym.destroy 
        render json: {}, status: :no_content
    end

    private 
    
    def render_not_found_response
        render json: {error: "Record not found"}, status: :not_found
    end

    def find_gym
        Gym.find(params[:id])
    end

    def gym_params
        params.permit(:name, :address)
    end

end
