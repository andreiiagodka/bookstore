$( document ).on('turbolinks:load', function(){
  $('#destroy_confirmation').change(function(e) {
    let destroy_confirmation_button = $('#destroy_confirmation_button')
    this.checked ? destroy_confirmation_button.removeClass('disabled') : destroy_confirmation_button.addClass('disabled')
  });
});
