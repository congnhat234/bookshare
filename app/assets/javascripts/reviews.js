$(document).ready(function() {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  $('#rate').on('click', function () {
    var fdata = new FormData();
    fdata.append('book_id', $('.rateyo').attr('data-id'));
    fdata.append('rating', $('.rateyo').rateYo('option', 'rating'));
    fdata.append('content', $('#content').val());
    $.ajax({
      url: '/reviews',
      type: 'POST',
      cache: false,
      processData: false,
      contentType: false,
      data: fdata,
      success: function (data) {
        $('#overrall').text('(' + data.overall + '/5)');
        $('.rateyo-readonly').attr('data-rating', data.overall);
        $('.rateyo-readonly').rateYo('option', 'rating', data.overall);
        $('.rateyo').rateYo('option', 'rating', 0);
        $('#content').val('');
        $('#review_list').prepend(data.review);
        $('#no_review').hide();
      },
      error: function () {
        Toast.fire({
          icon: 'error',
          title: I18n.t('alert.error')
        })
      }
    });
  });

  jQuery('body').on('click', '.delete_review_btn', function () {
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
        fdata.append('book_id', $('.rateyo').attr('data-id'));
        fdata.append('review_id', $(this).attr('data-id'));
        $.ajax({
          url: '/reviews/' + $(this).attr('data-id'),
          type: 'DELETE',
          cache: false,
          processData: false,
          contentType: false,
          data: fdata,
          success: function (data) {
            $('#overrall').text('(' + data.overall + '/5)');
            $('.rateyo-readonly').attr('data-rating', data.overall);
            $('.rateyo-readonly').rateYo('option', 'rating', data.overall);
            $('.rateyo').rateYo('option', 'rating', 0);
            $('#content').val('');
            $(self).closest('li').remove();
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
