require 'spec_helper'

describe FavoriteFoodsController, type: :controller do
  context 'guest' do
    it 'is redirected to login page' do
      get 'index'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'user' do
    let(:user) { create(:user) }

    before :each do
      sign_in user
    end

    describe 'GET index' do
      it 'returns success' do
        get :index
        expect(response).to be_success
      end
    end

    describe 'POST create' do
      it 'creates a new favorite food item' do
        food = create(:food)
        expect {
          post :create, { id: food.id }
        }.to change(FavoriteFood, :count).by(1)
      end
    end

    describe 'DELETE destroy' do
      it 'deletes the item from favorites' do
        favorite_food = create(:favorite_food, user: user)
        expect {
          delete :destroy, { id: favorite_food.id }
        }.to change(FavoriteFood, :count).by(-1)
      end
    end
  end
end
