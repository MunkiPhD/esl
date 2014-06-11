require 'rails_helper'

describe CircleMembersController, type: :controller do
  let(:user) { create(:user) }
  let(:user_two) { create(:user) }
  let(:circle) { create(:circle, user: user) }
  let(:private_circle) { create(:circle, is_public: false, user: user)}

  context "for authenticated users" do
    before :each do
      sign_in user
    end

    describe "GET 'index'" do
      it "populates an array of members in the circle" do
        circle.add_member user_two
        get :index, circle_id: circle
        expect(assigns(:members)).to match_array [user, user_two]
      end

      it "does not contain pending members" do
        circle.add_pending user_two
        get :index, circle_id: circle.id
        expect(assigns(:members)).to match_array [user]
      end

      it "renders the index view" do
        get :index, circle_id: circle.id
        expect(response).to render_template :index
      end
    end # end :index


    describe 'POST :join' do
      skip
    end


    describe 'POST :leave' do
      skip
    end


    describe 'GET :pending' do
      skip
    end


    describe 'POST :approve' do
      skip
    end

  end # end authenticated users

  context 'for un-authenticated users' do
    describe 'redirects to login page' do
      it ':index' do
        get :index, circle_id: circle.id
        expect(response).to redirect_to(new_user_session_path)
      end

      it ':join' do
        get :join, circle_id: circle.id
        expect(response).to redirect_to(new_user_session_path)
      end

      it ':leave' do
        get :leave, circle_id: circle.id
        expect(response).to redirect_to(new_user_session_path)
      end

      it ':pending' do
        get :pending, circle_id: circle.id
        expect(response).to redirect_to(new_user_session_path)
      end

      it ':approve' do
        get :approve, circle_id: circle.id, id: user_two.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
