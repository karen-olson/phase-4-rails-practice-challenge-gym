class ClientsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        clients = Client.all 
        render json: clients
    end

    def show 
        client = find_client
        render json: client, methods: :total_charges
    end

    def update 
        client = find_client
        if client.update(client_params)
            render json: client, status: :accepted 
        else 
            render json: {error: client.errors.full_messages}, status: :unprocessable_entity 
        end
    end


    private 
    
    def render_not_found_response
        render json: {error: "Record not found"}, status: :not_found
    end

    def find_client
        Client.find(params[:id])
    end

    def client_params
        params.permit(:name, :age)
    end
end
