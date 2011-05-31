require 'spec_helper'

describe "Sponsor Model" do
  let(:sponsor) { Sponsor.new }
  it 'can be created' do
    sponsor.should_not be_nil
  end
end
