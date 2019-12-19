$(document).ready(function() {
  if(check_logged_in_user()){
    App.cable.subscriptions.create('MessagesChannel', {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        $('#direct-conversation-'  + data.id).append(data.body);
        $('#inbox-counter').text(data.counter);
        if ($('#conversation-label-' + data.id).length == 0) {
          $('#conversation-' + data.id).find('a').append('<span class="badge bg-danger float-right" id="conversation-label-' + data.id + '">New</span>')
        }
        $(".direct-chat-messages").stop().animate({ scrollTop: $(".direct-chat-messages")[0].scrollHeight});
      }
    });
  }
});
