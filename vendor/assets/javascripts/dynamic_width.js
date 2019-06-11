/*
 * Source: https://stackoverflow.com/questions/1582534/calculating-text-width/15302051#15302051
 */

$(document).on('turbolinks:load', function () {
  $.fn.textWidth = function (text, font) {
    if (!$.fn.textWidth.fakeEl) $.fn.textWidth.fakeEl = $('<span>').hide().appendTo(document.body);
    $.fn.textWidth.fakeEl.text(text || this.val() || this.text()).css('font', font || this.css('font'));
    return $.fn.textWidth.fakeEl.width();
  };

  $('.dynamic-width').on('input', function () {
    $(this).width($(this).textWidth() + 2);
  }).trigger('input');
});
