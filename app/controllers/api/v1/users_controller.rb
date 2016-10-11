module Api
  module V1
  	class UsersController < ApplicationController
      before_action :set_user, only: [:show, :profic_update]
      #before_action :authenticate_api_v1_user!
      #before_action :require_same_user, only: [:show]

      ITEMS_PER_PAGE = 2

  	  def index
        if params[:page]
          @page_no = params[:page].to_i
        else
          @page_no = 1
        end

        if !@page_no.to_i.between?(1,((User.count.to_f/ITEMS_PER_PAGE).ceil))
          render json: { errors: ["Invalid page number."] }, status: 400 and return
        end

  	  	@users = User.offset((@page_no - 1) * ITEMS_PER_PAGE).limit(ITEMS_PER_PAGE)
        render json: { :last => (@page_no == (User.count.to_f/ITEMS_PER_PAGE).ceil), :data => @users }
  	  end

  	  def show
        render json: @user
  	  end

      def profic_update
        if @user.update(profic_params)
          render json: @user.image
        else
          render json: { errors: ["Invalid image."] }, status: 400
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def require_same_user
        if current_api_v1_user != @user
          render json: { errors: ["Authorized users only."] }, status: :unauthorized
        end
      end

      def profic_params
        params.require(:user).permit(:image)
      end

  	end
  end
end