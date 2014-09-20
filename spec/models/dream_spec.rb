require 'spec_helper'

describe Dream do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @dream = Dream.new(content: "Lorem ipsum", user_id: user.id)
  end

  subject { @dream }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  describe "when user_id is not present" do
    before { @dream.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @dream.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @dream.content = "a" * 8001 }
    it { should_not be_valid }
  end
end