module BookImage
  extend ActiveSupport::Concern

  COVERS_DIR = 'covers/'.freeze
  DEFAULT_COVER = 'default.jpg'.freeze

  BOOK_IMAGE_SIZES = {
    main_cover: '555x380',
    slider_cover: '250x310',
    cart_cover: '160x190',
    image: '170x120'
  }.freeze

  BOOK_IMAGE_CLASSES = {
    shadow: 'img-shadow',
    thubmnail: 'general-thumbnail-img'
  }.freeze

  def get_cover_image(type)
    cover.attached? ? cover_type(type) : COVERS_DIR . DEFAULT_COVER
  end

  def get_class_list(shadow)
    "#{BOOK_IMAGE_CLASSES[:shadow] if shadow} #{BOOK_IMAGE_CLASSES[:thubmnail]}"
  end

  private

  def cover_type(type)
    case type
    when :main then main_cover
    when :slider then slider_cover
    when :cart then cart_cover
    end
  end
end
