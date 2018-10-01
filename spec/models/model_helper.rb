def create_user(name = 'test name')
  User.create(name: name, password: 'password')
end

def create_task(user = create_user)
  user.tasks.create(description: 'test task')
end

def create_comment(task = create_task, user = create_user)
  task.comments.create(content: 'text comment', user_id: user.id)
end