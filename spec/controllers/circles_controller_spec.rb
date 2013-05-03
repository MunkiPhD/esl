require 'spec_helper'

describe CirclesController do
  let(:user) { create(:user) }
  let(:circle) { create(:circle, user: user) }

  context "for authenticated users" do
    before :each do
      sign_in user
    end

    describe "GET index" do
      it "assigns all circles as circles" do
        get :index, {}
        expect(assigns(:circles)).to match_array [circle]
      end

      describe "JSON" do
        pending
      end
    end


    describe "GET show" do
      it "assigns the requested circle as circle" do
        get :show, {:id => circle.to_param}
        expect(assigns(:circle)).to eq(circle)
      end

      describe "JSON" do
        pending
      end
    end

    describe "GET new" do
      it "assigns a new circle as circle" do
        get :new, {}
        expect(assigns(:circle)).to be_a_new(Circle)
      end
    end

    describe "GET edit" do
      it "assigns the requested circle as circle" do
        get :edit, {:id => circle.to_param}
        expect(assigns(:circle)).to eq(circle)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Circle" do
          expect {
            post :create, {:circle => attributes_for(:circle)}
          }.to change(Circle, :count).by(1)
        end

        it "assigns a newly created circle as circle" do
          post :create, {:circle => attributes_for(:circle)}
          expect(assigns(:circle)).to be_a(Circle)
          expect(assigns(:circle)).to be_persisted
        end

        it "redirects to the created circle" do
          post :create, {:circle => attributes_for(:circle)}
          expect(response).to redirect_to(Circle.last)
        end

        describe "JSON" do
          pending
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved circle as circle" do
          # Trigger the behavior that occurs when invalid params are submitted
          Circle.any_instance.stub(:save).and_return(false)
          post :create, {:circle => { "name" => "invalid value" }}
          expect(assigns(:circle)).to be_a_new(Circle)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Circle.any_instance.stub(:save).and_return(false)
          post :create, {:circle => { "name" => "invalid value" }}
          expect(response).to render_template("new")
        end

        describe "JSON" do
          pending
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested circle" do
          # Assuming there are no other circles in the database, this
          # specifies that the Circle created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Circle.any_instance.should_receive(:update).with({ "name" => "MyString" })
          put :update, {:id => circle.to_param, :circle => { "name" => "MyString" }}
        end

        it "assigns the requested circle as circle" do
          put :update, {:id => circle.to_param, :circle => attributes_for(:circle)}
          expect(assigns(:circle)).to eq(circle)
        end

        it "redirects to the circle" do
          put :update, {:id => circle.to_param, :circle => attributes_for(:circle)}
          expect(response).to redirect_to(circle)
        end

        describe "JSON" do
          pending
        end
      end

      describe "with invalid params" do
        it "assigns the circle as circle" do
          # Trigger the behavior that occurs when invalid params are submitted
          Circle.any_instance.stub(:save).and_return(false)
          put :update, {:id => circle.to_param, :circle => { "name" => "invalid value" }}
          expect(assigns(:circle)).to eq(circle)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Circle.any_instance.stub(:save).and_return(false)
          put :update, {:id => circle.to_param, :circle => { "name" => "invalid value" }}
          expect(response).to render_template("edit")
        end

        describe "JSON" do
          pending
        end
      end
    end

    describe "DELETE destroy" do
      it "the requested circle" do
        #user = create(:user)
        #circle = user.circles.build(attributes_for(:circle))
        #circle.save
        expect(user.has_role? :admin, circle).to eq true
        expect {
          delete :destroy, id: circle.to_param
        }.to change(Circle, :count).by(-1)
      end

      it "redirects to the circles list" do
        delete :destroy, {:id => circle.to_param}
        expect(response).to redirect_to(circles_url)
      end

      describe "JSON" do
        pending
      end
    end
  end



  context "for un-authenticated user" do
    it "GET 'index' displays the list of circles" do
      get :index
      expect(assigns(:circles)).to match_array [circle]
    end

    it "GET 'show' assigns the specified circle to circle" do
      get :show,  id: circle.id 
      expect(assigns(:circle)).to eq(circle)
    end

    it "GET 'new' redirects to sign in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "GET 'edit' redirects to sign in" do
      get :edit, id: circle.id
      expect(response).to redirect_to(new_user_session_path)
    end

    describe "POST #create" do
      it "does not save the circle to the db" do
        expect {
          post :create, circle: attributes_for(:circle)
        }.to change(Circle, :count).by(0)
      end

      it "redirects the user to the sign in page" do
        post :create, circle: attributes_for(:circle)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      it "does not update circle" do
        circle = create(:circle, name: "test")
        put :update, id: circle, circle: attributes_for(:circle, name: "updated")
        circle.reload
        expect(circle.name).to eq("test")
        expect(response).to redirect_to new_user_session_path
      end

      it "redirects to the user login" do
        put :update, id: circle, circle: attributes_for(:circle)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
