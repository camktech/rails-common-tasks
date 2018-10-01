require 'rails_helper'
require_relative 'model_helper'

RSpec.describe Task, type: :model do
  it 'is valid with valid attributes' do
    expect(create_task).to be_valid
  end

  it 'is not valid without a description' do
    user = create_user
    task = user.tasks.new
    expect(task).to be_invalid
  end

  it 'is not valid without a user_id' do
    task = Task.new(description: 'test task')
    expect(task).to be_invalid
  end

  it 'can be updated' do
    task = create_task
    task.update(description: 'new description', is_complete: true)
    expect(task.description).to eql('new description')
    expect(task.is_complete).to eql(true)
  end

  it 'can be deleted' do
    task = create_task
    user = task.user
    task.destroy
    expect(user.tasks.count).to eql(0)
  end

  it 'can have many comments' do
    task = create_task
    task.comments.create(content: 'text comment', user_id: task.user.id)
    task.comments.create(content: 'text comment', user_id: task.user.id)
    expect(Comment.where(task_id: task.id).count).to eql(2)
  end

  it 'destroys dependent comments on destroy' do
    task = create_task
    task.comments.create(content: 'text comment', user_id: task.user.id)
    expect(Comment.where(task_id: task.id).count).to eql(1)
    task.destroy
    expect(Comment.where(task_id: task.id).count).to eql(0)
  end

end
