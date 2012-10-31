require 'test_helper'

class PostTest < ActiveSupport::TestCase
   
	test 'post should have a title' do
    post = Post.new(:name => nil)
    assert !post.save, 'should have a title'
  end

  test 'post should have a content' do 
    post = Post.new(:content => nil)
    assert !post.save, 'should have a content'
  end

  test 'post should have a published date' do 
    post = Post.new(:published_at => nil)
    assert !post.save, 'should have a published date'
  end

  test 'post should have a author' do 
    post = Post.new(:author_id => nil)
    assert !post.save, 'should have a author'
  end

  test 'post should have a category' do 
    post = Post.new(:category_id => nil)
    assert !post.save, 'should have a category'
  end

  


end
