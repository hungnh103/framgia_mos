# require "elasticsearch/model"

class Post < ActiveRecord::Base
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  ATTRIBUTES_ROLES = [:read, :create, :update, :destroy, :destroy_all]

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  enum status: [:admin_create, :pending, :accepted, :rejected]
  enum post_type: [:normal, :audio]

  mount_uploader :image, PostPictureUploader
  mount_uploader :audio, PostMusicUploader

  validates :title, presence: true
  validates :category_id, presence: true
  validates :description, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :post_type, presence: true
  validate :validate_audio, on: :create

  delegate :name, to: :category, prefix: true

  # settings index: {number_of_shards: 1} do
  #   mappings dynamic: "false" do
  #     indexes :title, analyzer: "english", index_options: "offsets"
  #     indexes :description, analyzer: "english"
  #     indexes :content, analyzer: "english"
  #     indexes :author, analyzer: "english"
  #   end
  # end

  class << self
    def each_month year
      posts_per_month = (1..12).map do |month|
        {name: Date::MONTHNAMES[month], y: Post.posts_of_month(month, year)}
      end
    end

    def posts_of_month month, year
      Post.where(status: [:admin_create, :accepted])
        .where("year(created_at) = #{year} and month(created_at) = #{month}").size
    end

    # def elasticsearch query
    #   __elasticsearch__.search(
    #     {
    #       query: {
    #         multi_match: {
    #           query: query,
    #           fields: ["title^10", "content", "description", "author"]
    #         }
    #       }
    #     }
    #   )
    # end
  end


  def label_status
    case self.status
    when "accepted"
      "<label class= 'label label-success'>#{self.status}</label>"
    when "rejected"
      "<label class= 'label label-danger'>#{self.status}</label>"
    when "pending"
      "<label class= 'label label-info'>#{self.status}</label>"
    end
  end

  private
  def validate_audio
    if self.post_type == Settings.admin.posts.audio_post
      if self.audio.nil?
        self.errors.add :create,
          I18n.t(".error_audio")
      end
    end
  end
end

# Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

# Post.__elasticsearch__.client.indices.create \
#   index: Post.index_name,
#   body: {settings: Post.settings.to_hash, mappings: Post.mappings.to_hash}
# Post.import
