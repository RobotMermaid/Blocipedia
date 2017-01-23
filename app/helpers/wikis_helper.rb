module WikisHelper

  def premium_view?(wiki)
    !wiki.private || current_user.premium? || current_user.admin?
  end
end
