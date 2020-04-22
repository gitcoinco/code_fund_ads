#
# Used in the CreativesController to correctly verify that all image params
# are present since images are not assigned until after the creative is saved
#
class CreativeImageParamsValidator
  include ActiveModel::Validations

  attr_accessor :icon_image, :small_image, :large_image, :wide_image
  validates :icon_image, presence: {message: "must be selected"}
  validates :small_image, presence: {message: "must be selected"}
  validates :large_image, presence: {message: "must be selected"}
  validates :wide_image, presence: {message: "must be selected"}

  def initialize(params)
    @icon_image = params[:icon_blob_id]
    @small_image = params[:small_blob_id]
    @large_image = params[:large_blob_id]
    @wide_image = params[:wide_blob_id]
  end
end
