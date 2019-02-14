$(document).ready(function() {
  $('.btn-minus-js').click(function() {
    let input = $('.book-quantity-js')
    let quantity = Number(input.val())
    if (quantity > 1) {
      input.val(quantity - 1)
    }
  })

  $('.btn-plus-js').click(function() {
    let input = $('.book-quantity-js')
    input.val(Number(input.val()) + 1)
  })
})
