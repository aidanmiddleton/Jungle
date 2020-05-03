class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASS']

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category has been saved'
    else
      render :new
    end
  end

  private

  def cat_params
    params.require(:category).permit(
      :name
    )
  end
end
