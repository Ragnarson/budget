// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require tablesorter
//= require_tree ./global
//= require_self

$(document).ready(function () {
  var lang = document.location.pathname.replace(/^\/([^\/]*).*$/, '$1');
  if (!(lang == "en" || lang == "pl")) {
    lang = "en"
  }
  $('body').on("focus", "input.date_picker", function() {
    $(this).datepicker(
      $.datepicker.setDefaults($.datepicker.regional[lang])
    )
  })

  $('body').on("focus click", "input.currency", function () {
    if ($(this).val() == '0,00' || $(this).val() == '0.00') {
      $(this).val('')
    }
  })

  if ($("table#expenses").length) {
    $("table#expenses").tablesorter({
      headers: {3: {sorter: false}}
    });
  }
});

$(window).load(function () {
  $('div#ki_container').addClass('hidden-phone')
});
