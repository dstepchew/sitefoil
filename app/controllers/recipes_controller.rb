class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :authenticate_user!, except: [:new_animated]


  #is called by animated wizard after user signed up
  def after_user_create
    redirect_to "/sites/#{current_user.sites.first.id}", notice: "Your first recipe has been just created. To make it work please ADD CODE SNIPPET to your site."
  end

  def duplicate
    new_recipe = @recipe.dup
    new_recipe.enabled = false
    new_recipe.save

    session[:highlight_recipe_id] = new_recipe.id
    redirect_to "/recipes", notice: "Disabled copy of the recipe created"

  end

  def index
    @recipes = current_user.recipes.order(:created_at) if current_user
  end

  def show
  end

  def new
    @recipe = current_user.recipes.new
  end

  def new_animated    
  end


  def edit
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :site_id, :status, :js, :wizard_json, :hits, :description, :trigger_id, :act_id, :trig_channel_id, :enabled, :act_channel_id, 
              trigger_attributes: [
                 :id, :name, :description
              ],
              act_attributes: [
                 :id, :name, :description
              ])
    end
end
