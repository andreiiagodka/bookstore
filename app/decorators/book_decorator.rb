class BookDecorator < Draper::Decorator
  COVERS_DIR = 'covers/'
  DEFAULT_COVER = 'default.jpg'
  DEFAULT_COVER_CLASS = 'general-thumbnail-img'

  delegate_all

  decorates_association :reviews

  def authors_joined_by_comma
    authors.map(&:name).join(', ')
  end

  def short_name
    name[0..25]
  end

  def short_description
   description[0..150]
  end

 def image(type)
   if cover.attached?
     h.image_tag cover_type(type), class: "img-shadow #{DEFAULT_COVER_CLASS}"
   else
     h.image_tag COVERS_DIR . DEFAULT_COVER, class: DEFAULT_COVER_CLASS
   end
 end

 private

 def cover_type(type)
   case type
   when :large then cover_w250_h310
   when :small then cover_w160
   end
 end

end
