$(document).ready(function() {
  if ($(".direct-chat-messages").length > 0) {
    $(".direct-chat-messages").stop().animate({ scrollTop: $(".direct-chat-messages")[0].scrollHeight});
    $("#send_message").click(function() {
      $(".direct-chat-messages").stop().animate({ scrollTop: $(".direct-chat-messages")[0].scrollHeight});
    });
  }
})
