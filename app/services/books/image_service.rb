class Books::ImageService
  COVERS_DIR = 'covers/'.freeze
  DEFAULT_COVER = 'default.jpg'.freeze

  COVER_TYPES = {
    main: :main,
    slider: :slider,
    cart: :cart
  }.freeze

  IMAGE_SIZES = {
    main_cover: '555x380',
    slider_cover: '250x310',
    cart_cover: '160x190',
    image: '170x120'
  }.freeze

  IMAGE_CLASSES = {
    shadow: 'img-shadow',
    thubmnail: 'general-thumbnail-img'
  }.freeze

  def initialize(book)
    @book = book
  end

  def get_cover(type)
    @book.cover.attached? ? get_cover_by_type(type) : COVERS_DIR + DEFAULT_COVER
  end

  def get_class_list(shadow)
    "#{IMAGE_CLASSES[:shadow] if shadow} #{IMAGE_CLASSES[:thubmnail]}"
  end

  private

  def get_cover_by_type(type)
    case type
    when COVER_TYPES[:main] then main_cover
    when COVER_TYPES[:slider] then slider_cover
    when COVER_TYPES[:cart] then cart_cover
    end
  end

  def main_cover
    @book.cover.variant(resize: "#{IMAGE_SIZES[:main_cover]}!").processed
  end

  def slider_cover
    @book.cover.variant(resize: "#{IMAGE_SIZES[:slider_cover]}!").processed
  end

  def cart_cover
    @book.cover.variant(resize: "#{IMAGE_SIZES[:cart_cover]}!").processed
  end
end
