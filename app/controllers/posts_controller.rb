class PostsController < ApplicationController
  # before_action :set_params, only: [:create]

  def new
  end

  def create
    post = Post.new(set_params)
    # post.spot_id = params[:spot_id]
    # post.save
    # authorize post
  end

  def update
  end

  def destroy
  end

  private

  def set_params
    params.require(:post).permit(:description, :spot_id)
  end
end
