class PostsController < ApplicationController
  # before_action :set_params, only: [:create]

  def new
    @post = current_user.posts.new(set_params)
    authorize @post
  end

  def create
    # @post = Post.new(set_params)
    @post = Post.new
    @post.user_id = current_user.id
    @post.spot_id = params[:spot_id]
    @post.description = params[:no_model_fields][:other_field]
    authorize @post
    @post.save!

    # @post.description = params[:post][:description]
  if !params[:no_model_fields][:pictures].nil?
    params[:no_model_fields][:pictures].each do |pic|
      @post_content = PostContent.new
      @post_content.post_id = @post.id
      @post_content.media_url = pic
      # authorize @post_content
      @post_content.save!
    end
  end

    redirect_to spot_path(params[:spot_id])
    # if @post.save
    #   redirect_to spot_path(params[:spot_id])
    # else
    #   redirect_to spot_path(params[:spot_id])
    # end
  end

  def update
  end

  def destroy
  end

  private

  def set_params
    params.require(:post).permit(:description, :spot_id, { pictures: []})
  end
end
