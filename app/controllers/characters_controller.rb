class CharactersController < ApplicationController
  before_action :set_character

  def new
    @character = NovelCreateForm.new
  end

  def create
    @character = current_user.character.build(character_params)
    @character.save
  end

  def edit; end

  def update
    @character = current_user.character.find(params[:id])
    @character.update(character_params)
    redirect_to @character
  end

  private

  def character_params
    params.require(:novel_create_form).permit(:character, :character_role).merge(novel_id: params[:novel_id])
  end

  def set_character
    @character = @novel_create_form.character.find(params[:id])
  end
end
