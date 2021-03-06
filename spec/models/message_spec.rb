require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'can save' do
      it "is valid with a message" do
        message = build(:message, image: nil)
        expect(message).to be_valid

      end

      it "is valid with a image" do
        message = build(:message, content: nil)
        expect(message).to be_valid
      end

      it "is valid with a message and image" do
        expect(build(:message)).to be_valid
      end
    end

    context "can't save" do
      it "is invalid without both message and image" do
        message = build(:message, content: "", image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください。")
      end

      it "is invalid without group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it 'is invaid without user_id' do
       message = build(:message, user_id: nil)
       message.valid?
       expect(message.errors[:user]).to include('を入力してください')
     endt
    end
  end
end
