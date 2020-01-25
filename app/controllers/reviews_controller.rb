require 'pry'

class ReviewsController < ApplicationController
  before_action :authorize, only: [:new, :edit, :update, :create, :destroy]
  # def index
  #   # Code for listing all products goes here.
  # end

  def new
    @product = Product.find(params[:product_id])
    @user = current_user
    @review = @product.reviews.new
    render :new
  end

  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review successfully added!"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Something went wrong! Review not created."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @user = current_user
    if current_user.id === @review.user_id
      render :edit
    else
      flash[:alert] = "You are not authorized to edit this review"
      render :show
    end
  end

  def show
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :show
  end

  def update
    @review = Review.find(params[:id])
    @product = Product.find(params[:product_id])
    @user = current_user
    if @review.update(review_params)
      flash[:notice] = "Review successfully updated!"
      redirect_to product_path(@review.product)
    else
      flash[:alert] = "Something went wrong! Review not updated."
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user.id === @review.user_id
      @review.destroy
      flash[:notice] = "Review successfully destroyed!"
      redirect_to product_path(@review.product)
    else
      flash[:alert] = "You are not authorized to destroy this review"
      @product = Product.find(params[:product_id])
      render :show
    end
  end

    private
    def review_params
      params.require(:review).permit(:author, :rating, :content_body, :user_id)
    end
  end
