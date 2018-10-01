require 'rails_helper'
require_relative 'model_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    task = create_task
    expect(Comment.new(user_id: task.user.id, task_id: task.id, content: 'text comment')).to be_valid
  end

  it 'is invalid without a content attribute' do
    task = create_task
    expect(Comment.new(user_id: task.user.id, task_id: task.id)).to be_invalid
  end

  it 'is invalid without a task_id' do
    task = create_task
    expect(Comment.new(user_id: task.user.id, content: 'text comment')).to be_invalid
  end

  it 'is invalid without a user_id' do
    task = create_task
    expect(Comment.new(task_id: task.id, content: 'text comment')).to be_invalid
  end

  it 'can be updated' do
    task = create_task
    comment = Comment.new(user_id: task.user.id, task_id: task.id, content: 'text comment')
    comment.update(content: 'edited comment')
    expect(comment.content).to eql('edited comment')
  end

  it 'can be deleted' do
    task = create_task
    comment = task.comments.create(user_id: task.user.id, content: 'text comment')
    expect(task.comments.count).to eql(1)
    comment.destroy
    expect(task.comments.count).to eql(0)
  end

  it 'will be destroyed if parent task is destroyed' do
    task = create_task
    task_id = task.id
    task.comments.create(user_id: task.user.id, content: 'text comment')
    task.destroy
    expect(Comment.where(task_id: task_id).count).to eql(0)
  end

end
