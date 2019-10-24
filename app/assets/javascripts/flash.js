$(function() {
  setTimeout(function(){
    $('#flash').slideUp();
  }, 5000);
});

$(document).ready(function() {
  $(window).bind('rails:flash', function(e, params) {
    new PNotify({
      title: params.type,
      text: params.message,
      type: params.type
    });
  });
});
