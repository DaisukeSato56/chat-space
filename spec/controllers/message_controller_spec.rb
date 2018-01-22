require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    context "logged in" do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it "assigns the requested message to @message" do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns the requested group to @group" do
        expect(assigns(:group)).to eq group
      end

      it "render the :index template" do
        expect(response).to render_template :index
      end
    end

    context "not logged in" do
      before do
        get :index, params: { group_id: group.id }
      end

      it "redirects to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context "log in" do
      before do
        login user
      end

      context "can save" do
        subject {
          post :create, params: params
        }
        it "count up message" do
          expect{subject}.to change(Message, :count).by(1)
        end

        it "redirects to group_messages_path" do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end


      context "can't save" do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }
        subject {
          post :create, params: invalid_params
        }

        it "not count up message" do
          expect{subject}.not_to change(Message, :count)
        end

        it "redirects to group_messages_path" do
          subject
          expect(response).to redirect_to group_messages_path(group)
        end
      end
    end


    context "not log in" do
      subject {
        post :create, params: params
      }

      it "redirects new_user_session_path" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
