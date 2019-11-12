$(document).ready(function () {
  var $el, $menu, self
  var $btn = $('.more .more-btn')
  var visible = false

  function hideMenu (e) {
    if (("more-menu-btn" != $(event.target).attr('class'))) {
      if (visible) {
        visible = false
        $el.removeClass('show-more-menu')
        // $menu.attr('aria-hidden', true)
        // $(document).off('mousedown', hideMenu)
      }
    }
    return
  }

  $btn.on('click', function(e){
    $el = $(this).closest('.more')
    $menu = $el.next().find('.more-menu')
    e.preventDefault()
    if (!visible) {
      visible = true
      $el.addClass('show-more-menu')
      // $menu.attr('aria-hidden', false)
      $(document).on('mousedown', hideMenu)
    }
  })
})
