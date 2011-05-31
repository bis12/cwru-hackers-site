require 'spec_helper'

describe "Sponsorship Model" do
  let(:sponsorship) { Sponsorship.new }
  it 'can be created' do
    sponsorship.should_not be_nil
  end
end
