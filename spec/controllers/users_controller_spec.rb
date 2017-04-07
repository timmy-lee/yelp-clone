require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to(sign_in_path)
      end

      it 'sets the flash message' do
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'with invalid input' do
      before do
        post :create, params: {
          user: {
            username: Faker::Lorem.word,
            password: 'password'
          }
        }
      end
      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'renders the :new template' do
        expect(response).to render_template(:new)
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe 'GET show' do
    let(:user) { Fabricate(:user) }

    it 'sets @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'sets @reviews' do
      get :show, params: { id: user.id }
      business = Fabricate(:business)
      business2 = Fabricate(:business)
      review = Fabricate(:review, business_id: business.id, user_id: user.id)
      review2 = Fabricate(:review, business_id: business.id, user_id: user.id)
      expect(assigns(:reviews)).to match_array([review, review2])
    end
  end
end
