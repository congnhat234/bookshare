//= require admin-lte/plugins/jquery/jquery.min
//= require sweetalert2/dist/sweetalert2.all.min
//= require pnotify/dist/umd/PNotify
//= require pnotify/dist/umd/PNotifyButtons
//= require sweetalert_default_confirm
//= require rails-ujs
//= require cable
//= require admin-lte/plugins/bootstrap/js/bootstrap.bundle.min
//= require admin-lte/plugins/datatables/jquery.dataTables
//= require admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4
//= require admin-lte/plugins/bs-custom-file-input/bs-custom-file-input.min
//= require admin-lte/plugins/select2/js/select2.full.min
//= require admin-lte/dist/js/adminlte
//= require admin-lte/dist/js/demo
//= require admin-lte/plugins/summernote/summernote-bs4.min
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_self
//= require admin_post_status
//= require admin_book_status

$(document).ready(function () {
  $('#books_table').DataTable()
  $('#posts_table').DataTable()
  $('.editor').summernote()

  $("#input_file").on("change", function () {
    var preview = document.querySelector('.image-sortable');
    var files = document.querySelector('input[type=file]').files;

    function readAndPreview(file) {

      if (/\.(jpe?g|png|gif)$/i.test(file.name)) {
        var reader = new FileReader();

        reader.addEventListener("load", function () {
          var image = new Image();
          var parentDOM = document.createElement('div');
          parentDOM.className = 'image'
          var btn = document.createElement('a');
          btn.innerHTML = 'Remove';
          btn.className = 'remove-image'
          btn.href = 'javascript:void(0)'
          image.height = 340;
          image.width = 270;
          image.title = file.name;
          image.src = this.result;
          parentDOM.appendChild(image);
          parentDOM.appendChild(btn);
          preview.appendChild(parentDOM);
        }, false);

        reader.readAsDataURL(file);
        $(document).on('click', '.remove-image', function (e) {
          $(this).parent('.image').remove();
        });
      }

    }

    if (files) {
      [].forEach.call(files, readAndPreview);
    }
  })

  $('.edit_book').on('reset', function() {
    $('.image-sortable').html('')
  })
});
