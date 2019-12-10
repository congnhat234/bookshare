$(document).ready(function() {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  jQuery('body').on('click', '.activeBtn', function () {
    var self = this;
    var book_id = $(this).attr("data-id")
    var title = I18n.t('confirm.you_sure')
    var url = ''
    if ($(this).hasClass('active')) {
      title = I18n.t('confirm.inactive')
      url = '/admins/books/inactive'
    } else if ($(this).hasClass('inactive')) {
      title = I18n.t('confirm.active')
      url = '/admins/books/active'
    }
    Swal.fire({
      title: title,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: I18n.t('confirm.agree'),
      cancelButtonText: I18n.t('confirm.cancel')
    }).then((result) => {
      if (result.value) {
        var fdata = new FormData();
        fdata.append('id', book_id);
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
              title: I18n.t('alert.success[update_book]')
            })
          },
          error: function () {
            Toast.fire({
              icon: 'error',
              title: I18n.t('alert.error[update_book]')
            })
          }
        });
      }
    })
  });
})
