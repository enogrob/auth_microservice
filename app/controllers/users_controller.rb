class UsersController < ApplicationController
    def register
      user = User.new(user_params)
      if user.save
        render json: { message: 'User created successfully' }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = encode_token({ user_id: user.id })
        render json: { token: token }, status: :ok
      else
        render json: { errors: ['Invalid email or password'] }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(:email, :password)
    end
  
    def encode_token(payload)
      secret_key = Rails.application.credentials.jwt_secret_key
      JWT.encode(payload, secret_key)
    end
  end
  