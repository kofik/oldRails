require "rails_helper"

RSpec.describe Notifier, :type => :mailer do
  describe "order_received" do
    let(:mail) { Notifier.order_received }

    it "renders the headers" do
      expect(mail.subject).to eq("Order received")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "order_shipped" do
    let(:mail) { Notifier.order_shipped }

    it "renders the headers" do
      expect(mail.subject).to eq("Order shipped")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
