$(function () {
  var rating = $('.rateyo-readonly').attr('data-rating');
  if (rating == '') rating = 0

  $('.rateyo-readonly').rateYo({
    rating: rating,
    readOnly: true,
    starWidth: "20px"
  });

  $('.rateyo').rateYo({
    rating: 0,
    fullStar: true
  });
});
