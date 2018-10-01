require 'rails_helper'
require_relative 'model_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(create_user).to be_valid
  end

  it 'is not valid without a name' do
    expect(User.new(password: 'password')).to be_invalid
  end

  it 'must have a unique name attribute' do
    create_user
    duplicate_name_user = create_user
    expect(duplicate_name_user).to be_invalid
  end

  it 'can be updated' do
    user = create_user
    user.update(name: 'new name')
    expect(user.name).to eql('new name')
  end

  it 'can delete a task' do
    user = create_user
    task = create_task user
    task.destroy
    expect(user.tasks.count).to eql(0)
  end

  it 'can update a task' do
    user = create_user
    task = create_task user
    task.update(description: 'new description', is_complete: true)
    expect(task.description).to eql('new description')
    expect(task.is_complete).to eql(true)
  end

  it 'can delete a comment' do
    user = create_user
    task = create_task user
    comment = create_comment(task, user)
    comment.destroy
    expect(task.comments.count).to eql(0)
  end

  it 'can update a comment' do
    user = create_user
    task = create_task user
    comment = create_comment(task, user)
    comment.update(content: 'edited comment')
    expect(comment.content).to eql('edited comment')
  end

  it 'can comment on another user\'s task' do
    user = create_user
    user2 = create_user('user2')
    task = create_task user
    comment = create_comment(task, user2)
    expect(task.comments.first.user_id).to eql(user2.id)
  end

end
