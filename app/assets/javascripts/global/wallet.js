function add_fields(link, association, content) {
  var new_id = new Date().getTime()
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id))
}

function set_wallet_amount() {
  var sum = 0.0
  $('.expense_amount input.currency').each(function() {
    var input_value = parseFloat($(this).val().replace(',','.'))
    if(input_value > 0)
      sum += input_value
  })
  $('#total_amount').text(sum.toFixed(2))
}

function show_wallet_plan() {
  $('#add_expense_link').show()
  $('#plan_wallet_link').hide()
  $('#wallet_amount').hide()
  $('#total_header').show()
}

$(document).ready(function () {
  $('#add_expense_link').hide()
  $('#total_header').hide()

  $('body').on("change", ".expense_amount input.currency", set_wallet_amount)

  $('#plan_wallet_link').click(function() {
    show_wallet_plan()
    $('#total_amount').text('0')
  })

  if($('#wallet_plan').children().size()>0) {
    show_wallet_plan()
    set_wallet_amount()
  }
})
