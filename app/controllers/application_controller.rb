class ApplicationController < ActionController::Base
    class ApplicationController < ActionController::API
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
      
           before_action :authorize
        
          def encode_token(payload)
            # should store secret in env variable
            JWT.encode(payload, ENV["SECRET"])
          end
        
          def auth_header
            # { Authorization: 'Bearer <token>' }
            request.headers['Authorization']
          end
        
          def decoded_token
            if auth_header
              token = auth_header.split(' ')[1]
              # header: { 'Authorization': 'Bearer <token>' }
              begin
                JWT.decode(token, ENV["SECRET"], true, algorithm: 'HS256')
              rescue JWT::DecodeError
                nil
              end
            end
          end
        
          def current_user
            if decoded_token
              user_id = decoded_token[0]['user_id']
              @user = User.find_by(id: user_id)
            end
          end
        
          def logged_in?
            !!current_user
          end
        
          def authorize
            render json: { errors: ['Please log in'] }, status: :unauthorized unless logged_in?
          end
      
          def authorize_admin
            render json: {message: "You are not authorized to perform this action"}, status: :unauthorized unless current_user.user_type == 'admin'
          end
      
          private
      
          def render_not_found_response
            render json: { errors: "Item not found" }, status: :not_found
          end
      
          def render_unprocessable_entity_response(exception)
            render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
          end
        end
      
      
end
