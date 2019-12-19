$(document).ready(function() {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  $('#comment_btn').on('click', function () {
    var fdata = new FormData();
    var parrent_id = $('#comment').attr('parentid');
    fdata.append('post_id', $('#comment').attr('postid'));
    fdata.append('parent_id', $('#comment').attr('parentid'));
    fdata.append('content', $('#comment').val());
    $.ajax({
      url: '/comments',
      type: 'POST',
      cache: false,
      processData: false,
      contentType: false,
      data: fdata,
      success: function (data) {
        $('#comment').val('');
        $('#comment').attr('parentid', '');
        if (parrent_id) {
          $('#comment-' + parrent_id).prepend(data.comment);
        } else {
          $('#comment_list').prepend(data.comment);
        }
      },
      error: function () {
        Toast.fire({
          icon: 'error',
          title: I18n.t('alert.error')
        })
      }
    });
  });

  jQuery('body').on('click', '.reply_btn', function () {
    var parent_id = $(this).attr('parent_id');
    var user = $(this).attr('user');
    $('#comment').attr('parentid', parent_id);
    var newline = String.fromCharCode(13, 10);
    $('#comment').val(I18n.t('posts.comment.reply') + ' @' + user + ':' + newline);
    $('#comment').focus();
  });

  jQuery('body').on('click', '.delete_comment_btn', function () {
    var self = this;
    Swal.fire({
      title: I18n.t('confirm.you_sure'),
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: I18n.t('confirm.delete'),
      cancelButtonText: I18n.t('confirm.cancel')
    }).then(function(result) {
      if (result.value) {
        var fdata = new FormData();
        fdata.append('post_id', $(this).attr('pid'));
        fdata.append('comment_id', $(this).attr('commentid'));
        var parent_id = $(this).attr('parent_id');
        $.ajax({
          url: '/comments/' + $(this).attr('data_id'),
          type: 'DELETE',
          cache: false,
          processData: false,
          contentType: false,
          data: fdata,
          success: function (data) {
            $(self).closest('li').remove();
            if (parent_id) {
              $('#comment-' + parent_id).remove();
            }
            Toast.fire({
              icon: 'success',
              title: I18n.t('alert.delete')
            })
          },
          error: function () {
            Toast.fire({
              icon: 'error',
              title: I18n.t('alert.error')
            })
          }
        });
      }
    })
  });
});
