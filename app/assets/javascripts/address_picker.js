$(document).ready(function() {
  $('#select-country').select2({
    width: '24%'
  });
  $('#select-province').select2({
    width: '24%'
  });
  $('#select-district').select2({
    width: '24%'
  });
  $('#select-ward').select2({
    width: '24%'
  });

  $('#select-province').on('change', function () {
    load_district();
    load_wards();
    change_address();
  });

  $('#select-district').on('change', function () {
    load_wards();
    change_address();
  });

  $('#select-ward').on('change', function () {
    change_address();
  });

  $('#street').on('input', function () {
    change_address();
  });

  function load_district(selected_province) {
    var selected_province = $('#select-province').val();
    $.ajax({
      url: '/load-districts',
      type: 'POST',
      cache: false,
      data: {
        selected_province: selected_province
      },
      success: function (data) {
        $('#select-district').empty();
        data['districts'].forEach(function(element){
          var o = new Option(element[0], element[1]);
          $(o).html(element[0]);
          $('#select-district').append(o);
        });
      },
      error: function () {
        alert('fail');
      }
    });
  }

  function load_wards() {
    var selected_district = $('#select-district').val();
    $.ajax({
      url: '/load-wards',
      type: 'POST',
      cache: false,
      data: {
        selected_district: selected_district
      },
      success: function (data) {
        $('#select-ward').empty();
        data['wards'].forEach(function(element){
          var o = new Option(element[0], element[1]);
          $(o).html(element[0]);
          $('#select-ward').append(o);
        });
      },
      error: function () {
        alert('fail');
      }
    });
  }

  function change_address() {
    $('#address').val('');
    var country = $('#select-country option:selected').text();
    var province = $('#select-province option:selected').text();
    var district = $('#select-district option:selected').text();
    var ward = $('#select-ward option:selected').text();
    var street = $('#street').val();
    var address = street+ ', ' + ward + ', ' + district + ', ' + province + ', ' + country
    $('#address').val(address);
  }
});
