(function($) {
  var handleConfirm = function(element) {
    if (!allowAction(this)) {
      Rails.stopEverything(element)
    }
  }

  var allowAction = function(element) {
    if (element.getAttribute('data-confirm') === null) {
      return true
    }

    showConfirmationDialog(element)
    return false
  }

  var showConfirmationDialog = function(element) {
    var message = element.getAttribute('data-confirm')
    var text = element.getAttribute('data-text')

    Swal.fire({
      title: message || I18n.t('confirm.you_sure'),
      text: text || '',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: I18n.t('confirm.delete'),
      cancelButtonText: I18n.t('confirm.cancel'),
    }).then((result) => {
      if (result.value) {
        confirmed(element, confirm)
      }
    })
  }

  var confirmed = function(element, result) {
    if (result) {
      element.removeAttribute('data-confirm')
      element.click()
    }
  }

  document.addEventListener('rails:attachBindings', function() {
    Rails.delegate(document, 'a[data-confirm]', 'click', handleConfirm)
    Rails.delegate(document, 'button[data-confirm]', 'click', handleConfirm)
  })

}).call(this)
