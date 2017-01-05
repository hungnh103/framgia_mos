class User < ActiveRecord::Base

  ATTRIBUTES_ROLES = [:read, :block]

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_ralationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :active_relationships, source: :following
  has_many :following, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :roles_group

  delegate :roles_models, to: :roles_group
  delegate :name, to: :roles_group, prefix: true

  mount_uploader :avatar, UserAvatarUploader

  validates :name, presence: true, length: {maximum: 50}
  enum role: [:admin, :user]
  enum status: [:active, :blocked]

  def like? object
    object.likes.where(user_id: self.id).any?
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.avatar = auth.info.image
        user.password = Devise.friendly_token[0,20]
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
