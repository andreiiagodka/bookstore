class BookDecorator < Draper::Decorator
  delegate_all

  def authors_joined_by_comma
    authors.map(&:name).join(', ')
  end

  def short_description
   description[0..150]
 end

 def cover_image(type)
   if cover.attached?
     h.image_tag cover_type(type), class: 'img-shadow general-thumbnail-img'
   else
     h.image_tag 'covers/default.jpg', class: 'general-thumbnail-img'
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
