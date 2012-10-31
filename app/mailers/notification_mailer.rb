# coding : utf-8
class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_new_account(user)
    @user = user
    mail(:to => @user.email, :subject => "Conta Criada")
  end

  def notify_new_comment(comment)
    @comment = comment 
    @post    = @comment.post
    mail(:to => @post.author.email, :subject => "Seu post : #{@post.name}, recebeu um novo comentário")
  end
end
