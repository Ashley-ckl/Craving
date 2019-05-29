class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
    @reviews = Review.where(dish_id: params[:id])
    @count = @reviews.count
  end

  def new
    @dish = Dish.new
  end

  def create

    # @dish = Dish.new(strong_dish_params)
    # @dish.user = current_user
    # if @dish.save
    #   redirect_to dish_path(@dish)
    # else
    #   render :new
    # end
  end

  def search
    @restaurants = Restaurant.near(params[:address], 20)
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude
      }
    end
    if params[:address].present?
      @dishes = []
      @restaurants.each do |restaurant|
        restaurant.dishes.each do |dish|
          @dishes << dish
        end
      end
      @city = params[:address]
      @count = @dishes.count
    end
  end

  private

  def strong_dish_params
    params.require(:dish).permit(:name, :photo, :price, :rating, :category, :restaurant_id, :user_id)
  end
end
