require 'rails_helper'

RSpec.describe "payment_types/index", :type => :view do
  before(:each) do
    assign(:payment_types, [
      PaymentType.create!(
        :name => "Name"
      ),
      PaymentType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of payment_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
