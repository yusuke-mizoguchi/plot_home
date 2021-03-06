require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "reset_password_email" do
    let(:mail) { UserMailer.reset_password_email }

    it "renders the headers" do
      expect(mail.subject).to eq("パスワードリセット/PlotHome")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["isuke626shirobe@gmail.com"])
    end
  end
end
