require 'rails_helper'

describe ReviewsController do
  describe 'GET new' do
    let(:business) { Fabricate(:business) }

    context 'with authenticated users' do
      it 'sets @review' do
        session[:user_id] = Fabricate(:user).id
        get :new, params: { business_id: business.id }
        expect(assigns(:review)).to be_instance_of(Review)
      end
    end

    context 'with unauthenticated users' do
      it 'redirects the user to the sign-in page' do
        get :new, params: { business_id: business.id }
        expect(response).to redirect_to(sign_in_path)
      end

      it 'shows the flash message' do
        get :new, params: { business_id: business.id }
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated users' do
      let(:business) { Fabricate(:business) }
      let(:current_user) { Fabricate(:user) }

      before do
        session[:user_id] = current_user.id
      end

      context 'with valid inputs' do
        before do
          post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: current_user.id }
        end

        it 'redirects to the business show page' do
          expect(response).to redirect_to(business_path(business.id))
        end

        it 'creates a review' do
          expect(Review.count).to eq(1)
        end

        it 'creates a review associated with the business' do
          expect(Review.first.business).to eq(business)
        end

        it 'creates a review associated with the signed-in user' do
          expect(Review.first.user).to eq(current_user)
        end

        it 'create a successful flash message' do
          expect(flash[:notice]).not_to be_nil
        end
      end

      context 'with invalid inputs' do
        before do
          post :create, params: {
            review: {
              rating: 5,
            },
            user_id: current_user.id,
            business_id: business.id
          }
        end

        it 'does not create a review' do
          expect(Review.count).to eq(0)
        end

        it 'renders the new review template' do
          expect(response).to render_template(:new)
        end

        it 'sets @business' do
          expect(assigns(:business)).to eq(business)
        end

        it 'sets @review' do
          expect(assigns(:review)).to be_instance_of(Review)
        end
      end
    end

    context 'with unauthenticated users' do
      let(:business) { Fabricate(:business) }

      before do
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(sign_in_path)
      end

      it 'does not a review' do
        expect(Review.count).to eq(0)
      end

      it 'creates an error flash message' do
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'GET recent' do
    let(:business) { Fabricate(:business) }
    let(:user) { Fabricate(:user) }
    let(:review1) { Fabricate(:review, business_id: business.id, user_id: user.id) }
    let(:review2) { Fabricate(:review, business_id: business.id, user_id: user.id) }

    it 'sets @reviews' do
      get :recent
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it 'shows the latest 5 reviews' do
      review8 = Fabricate(:review, business_id: business.id, user_id: user.id)
      review4 = Fabricate(:review, business_id: business.id, user_id: user.id, created_at: Time.now+86400)
      review3 = Fabricate(:review, business_id: business.id, user_id: user.id, created_at: Time.now+100000)
      review5 = Fabricate(:review, business_id: business.id, user_id: user.id, created_at: Time.now+122321)
      review6 = Fabricate(:review, business_id: business.id, user_id: user.id, created_at: Time.now+36000)
      review7 = Fabricate(:review, business_id: business.id, user_id: user.id, created_at: Time.now+38000)
      get :recent
      expect(assigns(:reviews).count).to eq(5)
      expect(assigns(:reviews)).to eq([review5, review3, review4, review7, review6])
    end
  end
end
