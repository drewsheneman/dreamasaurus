require 'spec_helper'

describe "Dream pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "dream creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a dream" do
        expect { click_button "Post" }.not_to change(Dream, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'dream_content', with: "Lorem ipsum" }
      it "should create a dream" do
        expect { click_button "Post" }.to change(Dream, :count).by(1)
      end
    end
  end

  describe "dream destruction" do
    before { FactoryGirl.create(:dream, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a dream" do
        expect { click_link "delete" }.to change(Dream, :count).by(-1)
      end
    end
  end
end