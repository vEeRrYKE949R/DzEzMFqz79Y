# 代码生成时间: 2025-09-17 05:54:47
# 用户身份认证服务
# 使用HANAMI框架实现

require 'hanami'
require 'hanami/model'
require 'hanami/validations'
require 'bcrypt'

# 定义用户实体
class User < Hanami::Entity
end

# 定义用户验证实体
class User::Auth < Hanami::Entity
end

# 定义用户模型
class UserRepository < Hanami::Repository
  def create(user_params)
    user = User.new(user_params)
    user.password = BCrypt::Password.create(user_params[:password])
    user.save
  end

  def authenticate(username, password)
    user = users.find_by(username: username)
    if user && BCrypt::Password.new(user.password) == password
      user
    else
      nil
    end
  end

  private
  def users
    User
  end
end

# 用户身份认证服务
class AuthenticationService
  attr_reader :repository
  
  # 构造函数
  def initialize(repository: UserRepository.new)
    @repository = repository
  end
  
  # 创建用户
  def create_user(username:, email:, password:)
    validation = User::Auth.new({ username: username, email: email, password: password }).valid?
    if validation.valid?
      repository.create(username: username, email: email, password: password)
      return { status: :success, message: 'User created successfully' }
    else
      return { status: :error, message: validation.errors.to_h }
    end
  end
  
  # 用户登录
  def login(username:, password:)
    user = repository.authenticate(username, password)
    if user
      return { status: :success, message: 'Login successful', user: user }
    else
      return { status: :error, message: 'Invalid username or password' }
    end
  end
end

# 用户验证
class User::Auth
  include Hanami::Validations
  
  validations do
    required(:username).filled
    required(:email).filled
    required(:password).filled(size?: 8..100)
  end
end
