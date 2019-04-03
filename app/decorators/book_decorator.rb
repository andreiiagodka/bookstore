class BookDecorator < Draper::Decorator
  delegate_all

  decorates_association :reviews

  RANGES = {
    name: {
      short: 0..25
    },
    description: {
      short: 0..150,
      medium: 0..250,
      end: 250..-1
    }
  }.freeze

  def authors_joined_by_comma
    authors.map(&:name).join(', ')
  end

  def short_name
    name[RANGES[:name][:short]]
  end

  def first_sentence_description
    description.split('.').first
  end

  def short_description
    description[RANGES[:description][:short]]
  end

  def medium_description
    description[RANGES[:description][:medium]]
  end

  def end_of_description
    description[RANGES[:description][:end]]
  end

  def cover_image(type, shadow: true)
    image_service = Books::ImageService.new(self)
    h.image_tag image_service.get_cover(type), class: image_service.get_class_list(shadow)
  end

  def image(input)
    images[input].variant(resize: "#{Books::ImageService::IMAGE_SIZES[:image]}!").processed
  end
end
