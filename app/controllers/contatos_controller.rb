class ContatosController < ApplicationController

  def enviar
    flash[:notice] = ContactMailer.enviar_contato(params).deliver ? 'Mensagem Enviada com sucesso!' : 'Erro ao enviar, tente novamente'
    respond_with @mensagem, :location => root_path
  end

end

