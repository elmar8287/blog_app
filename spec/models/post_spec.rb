require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validation for posts' do
    user = User.create(name: 'Elik', bio: 'Test user')
    subject do
      Post.new(title: 'Elik`s post', text: 'This is text post', author_id: user)
    end

    before { subject.save }

    it 'Is counter a number' do
      subject.comments_counter = 'jdj'
      expect(subject).to_not be_valid
    end
  end
end
