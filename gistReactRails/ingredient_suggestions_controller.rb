class IngredientSuggestionsController < ApplicationController
  def index
    @ingredients = IngredientSuggestion.select("id, item").order("item ASC").to_json
  end
 
  def update
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.item = params[:item]
    ingredient.save!
    render :nothing => true, :status => 200
  end
 
  def destroy
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.destroy
    render :nothing => true, :status => 200
  end
end