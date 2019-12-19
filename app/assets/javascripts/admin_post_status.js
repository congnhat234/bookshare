$(document).ready(function() {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  jQuery('body').on('click', '.statusBtn', function () {
    var self = this;
    var post_id = $(this).attr("data-id")
    var title = I18n.t('confirm.you_sure')
    var url = ''
    if ($(this).hasClass('publish')) {
      title = I18n.t('confirm.unpublish')
      url = '/admins/posts/unpublish'
    } else if ($(this).hasClass('unpublish')) {
      title = I18n.t('confirm.publish')
      url = '/admins/posts/publish'
    }
    Swal.fire({
      title: title,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: I18n.t('confirm.agree'),
      cancelButtonText: I18n.t('confirm.cancel')
    }).then(function(result) {
      if (result.value) {
        var fdata = new FormData();
        fdata.append('id', post_id);
        $.ajax({
          url: url,
          type: 'POST',
          cache: false,
          processData: false,
          contentType: false,
          data: fdata,
          success: function (data) {
            $(self).closest('td').html(data.status)
            Toast.fire({
              icon: 'success',
              title: I18n.t('alert.success[update_post]')
            })
          },
          error: function () {
            Toast.fire({
              icon: 'error',
              title: I18n.t('alert.error[update_post]')
            })
          }
        });
      }
    })
  });
})
