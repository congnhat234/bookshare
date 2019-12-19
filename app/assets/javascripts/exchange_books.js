$(document).ready(function() {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  jQuery('body').on('click', '.actionExchangeBtn', function () {
    var self = this;
    var exchange_book_id = $(this).attr("id_sb")
    var type = $(this).attr("type")
    var title = I18n.t('confirm.change_status')
    var url = ''
    switch(type) {
      case "confirm":
        url = '/dashboard/exchange_books/confirm/' + exchange_book_id
        break
      case "approve":
        url = '/dashboard/exchange_books/approve/' + exchange_book_id
        break
      case "reject":
        url = '/dashboard/exchange_books/reject/' + exchange_book_id
        break
      case "done":
        url = '/dashboard/exchange_books/done/' + exchange_book_id
        break
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
        $.ajax({
          url: url,
          type: 'POST',
          cache: false,
          processData: false,
          contentType: false,
          data: fdata,
          success: function (data) {
            $('.status').html(data.status)
            $(self).closest('td').html(data.action)
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
