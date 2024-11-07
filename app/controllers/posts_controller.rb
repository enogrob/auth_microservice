class PostsController < ApplicationController
    before_action :authorized
  
    def index
      posts = [
        { id: 1, title: 'First Post', content: 'This is an example post.' }
      ]
      render json: posts
    end
  end
  