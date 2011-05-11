require 'spec_helper'

describe "Talk Model" do
  let(:talk) { Talk.new }
  it 'can be created' do
    talk.should_not be_nil
  end
end
