require 'rails_helper'

RSpec.describe "AdminNovels", type: :system do
    let(:user) { create(:user, :admin) }
    let(:novel) { create(:novel) }

    before do
        login(admin)
        visit admin_novels_path
    end
end