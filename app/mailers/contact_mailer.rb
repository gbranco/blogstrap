# coding : utf-8
class ContactMailer < ActionMailer::Base
  default from: "from@example.com",
          subject: 'Formulário de contato'

  def enviar_contato(args)
    @args = args
    mail(:to => 'lccezinha@gmail.com')
  end

end

