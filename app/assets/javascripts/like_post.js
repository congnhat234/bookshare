$(document).ready(function () {
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
      }
    })
  })
})
