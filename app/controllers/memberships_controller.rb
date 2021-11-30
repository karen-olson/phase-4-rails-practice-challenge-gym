class MembershipsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        memberships = Membership.all 
        render json: memberships
    end

    def create 
        membership = Membership.new(membership_params)
        if membership.save
            render json: membership, status: :created 
        else 
            render json: {error: membership.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    private 
    
    def render_not_found_response
        render json: {error: "Record not found"}, status: :not_found
    end

    def find_membership
        Membership.find(params[:id])
    end

    def membership_params
        params.permit(:client_id, :gym_id, :charge)
    end
end
