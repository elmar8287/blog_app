require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation for users' do
    subject { User.new(name: 'Elik', bio: 'Elik bio', posts_counter: 1) }

    before { subject.save }

    it 'Is bio true' do
      subject.bio = 'Elik bio'
      expect(subject).to be_valid
    end
  end
end
