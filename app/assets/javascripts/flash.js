$(function() {
  setTimeout(function(){
    $('#flash').slideUp();
  }, 7000);
});

$(document).ready(function() {
  $(window).bind('rails:flash', function(e, params) {
    new PNotify({
      title: params.type,
      text: params.message,
      type: params.type
    });
  });

  $('.language_option').on('click', function() {
    language = $(this).attr('data-language');
    window.location.href = "/language?locale=" + language;
  });

});
