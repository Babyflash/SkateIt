class Api::V1::PostsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index]

  protect_from_forgery prepend: true

  respond_to :json

  def index
    @posts = Post.where("spot_id = ?", params[:spot_id]).order('created_at DESC')
    render json: @posts
  end

  def create
    @post = Post.new(set_params)
    if @post.save
      render json: @post if @post.persisted?
    else
      render_error
    end
  end

  private

  def set_params
    params.require(:post).permit(:description, :user_id, :spot_id)
  end

  def render_error
    render json: { errors: @post.errors.full_messages },
      status: :unprocessable_entity
  end
end
