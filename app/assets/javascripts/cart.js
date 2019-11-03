$(document).ready(function() {
  $('.cart').on('click', function () {
    var book_id = $(this).attr('data-book-id');
    var qty = $("#qty").val();
    console.log(book_id, qty);
    $.ajax({
      url: '/cart/add',
      type: 'POST',
      cache: false,
      data: {
        book_id: book_id,
        qty: qty
      },
      success: function (data) {
        $('.product_qun').text(data.size_cart);
        alert(I18n.t("alert.success[add_cart]"));
      },
      error: function () {
        alert(I18n.t("alert.error[add_cart]"));
      }
    });
  });

  $('.cart-qty').change(function () {
    var book_id = $(this).attr('data-book-id');
    var quantity = $(this).val();
    $.ajax({
      url: '/cart/update/' + book_id,
      type: 'PUT',
      cache: false,
      data: {
        quantity: quantity
      },
      success: function (data) {
        $('#input-quantity-' + book_id).attr('value', data.total_quantity);
        $('#total-price-' + book_id).text(data.total_price);
        $('.cart-total').text(data.cart_total);
        $('.grand-total').text(data.grand_total);
      },
      error: function () {
        alert(I18n.t("alert.error[update_cart]"));
      }
    });
  });
});
