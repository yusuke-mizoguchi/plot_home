require 'rails_helper'

RSpec.describe "AdminNovels", type: :system do
    let(:user) { create(:user, :admin) }
    let(:novel) { create(:novel) }
end