class Photo < ApplicationRecord
  before_save :geocode_shot_location

  def geocode_shot_location
    if self.shot_location.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.shot_location)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.shot_location_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.shot_location_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.shot_location_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  mount_uploader :image, ImageUploader

  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :likes,
             :class_name => "Vote",
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => :posted_photos_count

  # Indirect associations

  has_many   :commenters,
             :through => :comments,
             :source => :commenter

  has_many   :followers,
             :through => :owner,
             :source => :followers

  has_many   :fans,
             :through => :likes,
             :source => :user

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

end
