$(document).ready(function() {
  $('.cart').on('click', function () {
    var book_id = $(this).attr('data-book-id');
    var qty = $("#qty").val();
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
        PNotify.success({
          text: I18n.t('alert.success[add_cart]')
        });
      },
      error: function () {
        PNotify.error({
          text: I18n.t('alert.error')
        });
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
        PNotify.error({
          text: I18n.t('alert.error')
        });
      }
    });
  });

  $('.collect').on('click', function () {
    var book_id = $(this).attr('data-book-id');
    var qty = $("#qty").val();
    $.ajax({
      url: '/dashboard/sharing_books',
      type: 'POST',
      cache: false,
      data: {
        id: book_id,
        qty: qty
      },
      success: function (data) {
        if (data.status == "success") {
          PNotify.success({
            text: I18n.t('alert.success[collect_book]')
          });
        } else {
          PNotify.error({
            text: I18n.t('alert.error')
          });
        }
      },
      error: function () {
        PNotify.error({
          text: I18n.t('alert.error')
        });
      }
    });
  });

  $('.checkout__title').click(function(e) {
    $(this).find('input').prop('checked', 'checked');
 });
});
