class DreamsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def create
    @dream = current_user.dreams.build(dream_params)
    if @dream.save
      flash[:success] = "Dream created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @dream.destroy
    redirect_to root_url
  end

  private

    def dream_params
      params.require(:dream).permit(:content)
    end

    def correct_user
      @dream = current_user.dreams.find_by(id: params[:id])
      redirect_to root_url if @dream.nil?
    end
end
