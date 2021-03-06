module SessionsHelper

  def sign_in(user)
    cookies.permanent[:persistence_token] = user.persistence_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_persistence_token(cookies[:persistence_token])
  end

  def current_user?(user)
    user == current_user
  end

  def box_owner?(box)
    !box.nil? && current_user == User.find(box.user_id)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def not_signed_in_user
    if signed_in?
      store_location
      flash[:info] = "Please sign out to use this feature."
      redirect_to root_path
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:persistence_token)
  end

  def anti_spam
    session['antispam_timestamp'] ||= Time.now
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def store_hostname
    session[:host_name] = request.host
  end

  def hostname
    session[:host_name]
  end

end
