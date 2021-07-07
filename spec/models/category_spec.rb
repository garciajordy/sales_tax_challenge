require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
