require 'rails_helper'

RSpec.describe "AdminUsers", type: :system do
    let(:admin) { create(:user, :admin) }
    let(:reader) { create(:user, :reader) }
end
