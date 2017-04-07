require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
    it 'sets @businesses' do
      omakase = Fabricate(:business)
      gen = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([omakase, gen])
    end
  end

  describe 'GET new' do
    context 'with authenticated users' do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it 'sets @business' do
        get :new
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end

    context 'with unauthenticated users' do
      it 'redirects to the list of businesses page' do
        get :new
        expect(response).to redirect_to(businesses_path)
      end
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, params: { business: Fabricate.attributes_for(:business) }
      end

      it 'creates the business' do
        expect(Business.count).to eq(1)
      end

      it 'redirects to the businesses page' do
        expect(response).to redirect_to(businesses_path)
      end
    end

    context 'with invalid inputs' do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, params: {
          business: {
            name: Faker::Lorem.word
          }
        }
      end

      it 'does not create the business' do
        expect(Business.count).to eq(0)
      end

      it 'renders the :new template' do
        expect(response).to render_template(:new)
      end

      it 'sets @business' do
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end
  end

  describe 'GET show' do
    let(:business) { Fabricate(:business) }

    it 'does not require a signed-in user' do
      session[:user_id] = nil
      get :show, params: { id: business.id }
      expect(response).to render_template(:show)
    end

    it 'sets @business' do
      get :show, params: { id: business.id }
      expect(assigns(:business)).to eq(business)
    end
  end
end
