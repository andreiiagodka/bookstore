class BookDecorator < Draper::Decorator
  delegate_all

  DESCRIPTION_LENGTH = {
    short: 150,
    medium: 250
  }.freeze

  DESCRIPTION_END_RANGE = (250...-1).freeze

  def authors_as_string
    authors.map(&:name).join(', ')
  end

  def categories_as_string
    categories.map(&:name).join(', ')
  end

  def first_sentence_description
    description.split('.').first
  end

  def short_description
    description.first(DESCRIPTION_LENGTH[:short])
  end

  def medium_description
    description.first(DESCRIPTION_LENGTH[:medium])
  end

  def end_of_description
    description[DESCRIPTION_END_RANGE]
  end

  def cover_image(type, shadow: true)
    image_service = Books::ImageService.new(self)
    h.image_tag image_service.get_cover(type), class: image_service.get_class_list(shadow)
  end

  def image(input)
    images[input].variant(resize: "#{Books::ImageService::IMAGE_SIZES[:image]}!").processed
  end
end
