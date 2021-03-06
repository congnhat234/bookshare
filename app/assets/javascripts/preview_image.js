$(function () {
  $('.upload-image').on('change', function () {
    var preview = document.querySelector('#preview-image')
    var files = document.querySelector('input[type=file]').files

    function readAndPreview (file) {
      if (/\.(jpe?g|png|gif)$/i.test(file.name)) {
        var reader = new FileReader()

        reader.addEventListener(
          'load',
          function () {
            var image = new Image()
            // image.height = 100;
            // image.width = 100;
            image.title = file.name
            image.src = this.result
            preview.innerHTML = ''
            preview.appendChild(image)
          },
          false
        )

        reader.readAsDataURL(file)
      }
    }

    if (files) {
      ;[].forEach.call(files, readAndPreview)
    }
  })
})

$(document).ready(function () {
  var readURL = function (input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader()

      reader.onload = function (e) {
        $('.avatar').attr('src', e.target.result)
      }

      reader.readAsDataURL(input.files[0])
    }
  }

  $('.file-upload').on('change', function () {
    readURL(this)
  })
})
