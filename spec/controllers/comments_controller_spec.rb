require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe CommentsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  User.create(name: 'user1', password: 'password')
  User.first.tasks.create(description: 'test description')
  let(:valid_attributes) {
    {
      content: 'test comment', 
      user_id: User.first.id, 
      task_id: Task.first.id
    }
  }

  let(:invalid_attributes) {
    {content: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  let(:valid_session) { {user_id: User.first.id} }


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, params: {comment: valid_attributes, task_id: valid_attributes[:task_id]}, session: valid_session
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the created comment" do
        post :create, params: {comment: valid_attributes, task_id: valid_attributes[:task_id]}, session: valid_session
        expect(response).to redirect_to(Comment.last.task)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {comment: invalid_attributes, task_id: valid_attributes[:task_id]}, session: valid_session
        expect(response).to redirect_to(Task.find(valid_attributes[:task_id]))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {content: 'edited comment'}
      }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        put :update, params: {id: comment.to_param, task_id: comment.task.id, comment: new_attributes}, session: valid_session
        comment.reload
        expect(comment.content).to eql('edited comment')
      end

      it "redirects to the comment" do
        comment = Comment.create! valid_attributes
        put :update, params: {id: comment.to_param, task_id: comment.task.id, comment: valid_attributes}, session: valid_session
        expect(response).to redirect_to(comment.task)
      end

      it "does not update the requested comment if it belongs to a different user" do
        comment = Comment.create! valid_attributes.merge(user_id: User.create(name: 'user2', password: 'password').id)
        put :update, params: {id: comment.to_param, task_id: comment.task.id, comment: new_attributes}, session: valid_session
        comment.reload
        expect(comment.content).to eql('test comment')
      end

    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        comment = Comment.create! valid_attributes
        put :update, params: {id: comment.to_param, task_id: comment.task.id, comment: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(comment.task)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, params: {id: comment.to_param, task_id: comment.task.id}, session: valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "does not destroy the requested comment if it belongs to a different user" do
      comment = Comment.create! valid_attributes.merge(user_id: User.create(name: 'user2', password: 'password').id)
      expect {
        delete :destroy, params: {id: comment.to_param, task_id: comment.task.id}, session: valid_session
      }.to change(Comment, :count).by(0)
    end

    it "redirects to the comments list" do
      comment = Comment.create! valid_attributes
      delete :destroy, params: {id: comment.to_param, task_id: comment.task.id}, session: valid_session
      expect(response).to redirect_to(comment.task)
    end
  end

end
