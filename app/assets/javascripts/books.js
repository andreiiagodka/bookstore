$(document).on('turbolinks:load', function() {
  $('.btn-minus-js').click(function() {
    let input_field = $(this).parent().find('.book-quantity-js')
    let quantity = Number(input_field.val())
    if (quantity > 1) {
      input_field.val(quantity - 1)
    }
  })

  $('.btn-plus-js').click(function() {
    let input_field = $(this).parent().find('.book-quantity-js')
    input_field.val(Number(input_field.val()) + 1)
  })

  $('.read-more-js').click(function() {
    let dots = $('.dots-js')
    let btn_link = $('.read-more-js')
    let description_end = $('.end-of-description-js')
    if (dots.css('display') == 'inline') {
      dots.hide()
      btn_link.text('Close')
      description_end.show()
    } else {
      dots.show()
      btn_link.text('Read more')
      description_end.hide()
    }
  })
})
