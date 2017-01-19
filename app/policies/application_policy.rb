class ApplicationPolicy
  attr_reader :user, :wiki
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, wiki.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.premium?
        scope.all
      else
        scope.where(private: false)
      end
    end
  end

end
