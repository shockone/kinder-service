#encoding: utf-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth request.env['omniauth.auth']
    if user.persisted?
      sign_in_and_redirect user
    else
      flash[:notice] = "Не вдалось увійти через #{request.env['omniauth.auth'][:provider]}: #{user.errors.full_messages.first}"
      redirect_to :back
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
end
