# require 'rails_helper'

# RSpec.describe Post, type: :model do
#   describe 'GET /index' do
#     subject { Post.new(title: 'Post title', text: 'Long lorem ipsum text', author: User.first) }
#     before { subject.save }

#     it 'Title must not be blank' do
#       subject.title = ''
#       expect(subject).to_not be_valid
#     end

#     it 'Title must not exceed 250 characters' do
#       subject.title = 'a' * 251
#       expect(subject).to_not be_valid
#     end

#     it 'CommentsCounter must be an integer' do
#       subject.comments_counter = 1.5
#       expect(subject).to_not be_valid
#     end

#     it 'CommentsCounter must be greater than or equal to zero.' do
#       subject.comments_counter = -1
#       expect(subject).to_not be_valid
#     end

#     it 'LikesCounter must be an integer' do
#       subject.likes_counter = 1.5
#       expect(subject).to_not be_valid
#     end

#     it 'LikesCounter must be greater than or equal to zero.' do
#       subject.likes_counter = -1
#       expect(subject).to_not be_valid
#     end
#   end
# end
