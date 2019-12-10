$(document).ready(function() {
  if(check_logged_in_user()){
    App.cable.subscriptions.create('NotificationsChannel', {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        $('#notifications_list').prepend(data.content);
        $('#notifications-number').text(data.counter);
        $('#header_all_read').removeClass('hidden');
        if (data.counter > 4) {
          $('#notifications_list li').last().prev().remove();
        }
        this.show_message(data);
      },
      show_message: function(data) {
        switch (data.type) {
          case 'review_create':
            PNotify.info({
              title: I18n.t('notifications.review_create'),
              text: data.message,
              icon: 'far fa-bell'
            });
            break;
          case 'comment_create':
            PNotify.info({
              title: I18n.t('notifications.comment_create'),
              text: data.message,
              icon: 'far fa-bell'
            });
            break;
          default:
            PNotify.info(I18n.t('action.success'), I18n.t('notifications.complete'));
        }
      }
    });
  }

  jQuery('body').on('click', '.message', function () {
    var id = $(this).attr('data_id');
    var url = '/notifications/' + id;
    var redirect_url = $(this).attr('data_href');
    $.ajax({
      url: url,
      type: 'PATCH',
      cache: false,
      success: function (data) {
        window.location.replace(redirect_url);
      },
      error: function () {
        alert(I18n.t('alert.error[notification]'));
      }
    });
  });
});
