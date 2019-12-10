$(document).ready(function () {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  $(document).on('click', '#follow-btn', function () {
    var user_id = $(this).attr('data-user-id')
    $.ajax({
      url: '/relationships',
      type: 'POST',
      cache: false,
      data: {
        followed_id: user_id
      },
      success: function (data) {
        Toast.fire({
          icon: 'success',
          title: I18n.t('alert.followed')
        })
      },
      error: function () {
        Toast.fire({
          icon: 'error',
          title: I18n.t('alert.error')
        })
      }
    })
  })
  $(document).on('click', '#unfollow-btn', function () {
    var relationship_id = $(this).attr('data-relationship-id')
    $.ajax({
      url: '/relationships/' + relationship_id,
      type: 'DELETE',
      cache: false,
      success: function (data) {
        Toast.fire({
          icon: 'success',
          title: I18n.t('alert.unfollowed')
        })
      },
      error: function () {
        Toast.fire({
          icon: 'error',
          title: I18n.t('alert.error')
        })
      }
    })
  })
})
