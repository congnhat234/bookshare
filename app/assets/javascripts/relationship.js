$(document).ready(function () {
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
      },
      error: function () {
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
      },
      error: function () {
      }
    })
  })
})