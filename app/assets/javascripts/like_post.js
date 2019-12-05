$(document).ready(function () {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  });
  $(document).on('click', '.like-btn', function () {
    var post_id = $(this).attr('data-post-id')
    $.ajax({
      url: '/liked_posts',
      type: 'POST',
      cache: false,
      data: {
        post_id: post_id
      },
      success: function (data) {
      },
      error: function () {
        Toast.fire({
          icon: 'error',
          title: I18n.t('alert.error')
        })
      }
    })
  })
  $(document).on('click', '.unlike-btn', function () {
    var liked_post_id = $(this).attr('data-liked-post-id')
    $.ajax({
      url: '/liked_posts/' + liked_post_id,
      type: 'DELETE',
      cache: false,
      success: function (data) {
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
