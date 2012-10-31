require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 	fixtures :comments, :posts

  test 'should have name ' do
  	comment = Comment.new(:name => nil)
  	assert !comment.save, 'should have a name !' 
  end

  test 'should have a content' do 
    comment = Comment.new(:content => nil)
    assert !comment.save, 'should have a content !'
  end

  test 'should belongs_to a post' do 
  	comment = Comment.new(:post_id => nil)
  	assert !comment.save, 'should belongs_to a post !'
  end

  test 'should have a email ' do 
  	comment = Comment.new(:email => nil)
  	assert !comment.save, 'should belongs_to a email !'
  end

  test 'email should have a valid format ' do 
 		comment = Comment.new(:email => 'meuemail@email.com')
 		assert_match comment.email, /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
 		assert !comment.save, 'should have a valid format of email'
  end

  #some obvious tests, just to learn more about it.
  test 'should be a Comment instance' do 
  	comment = Comment.new
  	assert_instance_of Comment, comment, 'should be a instance of Comment '
  end

  test "should respond_to method 'new_comments' " do
  	comment = Comment.new
  	assert_respond_to Comment, :new_comments, 'should respond_to to method (new_comments) ' 
  end

  test "should respond_to method 'search' " do 
    comment = Comment.new
    assert_respond_to Comment, :search, 'shuld respond_to to method (search) '
  end 

  test 'should respont_to method -comments_to_post- ' do 
    comment = Comment.new 
    assert_respond_to Comment, :comments_to_post, 'should respond_to'
  end


  
end
