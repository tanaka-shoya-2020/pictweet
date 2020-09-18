class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]
  # before_action :are_you_posted, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    # @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end
  
  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private

    def tweet_params
      params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def move_to_index
      unless user_signed_in?
        redirect_to action: :index
      end
    end
    
    # def are_you_posted
    #   unless user_signed_in? && @current_user.id == @tweet.user_id
    #     redirect_to action: :index
    #   end
    # end
end
