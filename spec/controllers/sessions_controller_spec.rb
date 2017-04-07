require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders a sign-in template for unauthenticated users' do
      get :new
      expect(response).to render_template('users/sign_in')
    end

    context 'with authenticated users' do
      it 'redirects to businesses page' do
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :new
        expect(response).to redirect_to(businesses_path)
      end

      it 'sets an error message' do
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :new
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      let(:richard) { Fabricate(:user) }

      before do
        post :create, params: { username: richard.username, password: richard.password}
      end

      it 'puts signed in user in the session' do
        expect(session[:user_id]).to eq(richard.id)
      end

      it 'redirects to the businesses path' do
        expect(response).to redirect_to(businesses_path)
      end

      it 'sets the flash message' do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      let(:jacky) { Fabricate(:user) }

      before do
        post :create, params: { username: jacky.username, password: jacky.username + '1'}
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to(sign_in_path)
      end

      it 'does not put a user in the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'sets the error message' do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it 'sets the session to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the businesses page' do
      expect(response).to redirect_to(businesses_path)
    end

    it 'seets the flash notice' do
      expect(flash[:notice]).not_to be_blank
    end
  end
end
