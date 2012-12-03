function add_fields(link, association, content) {
  var new_id = new Date().getTime()
  var regexp = new RegExp("new_" + association, "g")
  if (link['id'] === "plan_wallet_link"){
    $(link).parent().prev().before(content.replace(regexp, new_id))
  }
  else{
    $(link).parent().before(content.replace(regexp, new_id))
  }
}

function set_wallet_amount() {
  var sum = 0.0  
  $('.expense_amount input.currency').each(function() {
    var input_value = parseFloat($(this).val().replace(',','.'))
    if(input_value > 0)
      sum += input_value
  })
  $('#wallet_amount input.currency').val(sum.toFixed(2))
}

function show_wallet_plan() {
  $('#plan_wallet_link').hide()
  $('#add_expense_link').show()
  $('#wallet_amount input.currency').prop('disabled', true);
  $('#wallet_amount input.currency').val(0);
}

function hide_wallet_plan() {
  $('#wallet_amount input.currency').prop('disabled', false);
  $('#add_expense_link').hide()
  $('#plan_wallet_link').show()
}

$(document).ready(function () {
  //if validation errors
  if ($('.expense_amount:visible').length > 0) {
    show_wallet_plan()
    set_wallet_amount()
  }
  else
    hide_wallet_plan()

  $('body').on("change", ".expense_amount input.currency", set_wallet_amount)
  $('#plan_wallet_link').click(show_wallet_plan)

  //removing expenses
  $('form').on('click', '.remove_fields', function(event){
    $(this).parent().find('input[type=hidden]').val(1)
    $(this).parent().find("input.currency").val(0)
    $(this).closest('.row').hide()
    set_wallet_amount()
    if ($('.expense_amount:visible').length == 0)
      hide_wallet_plan()
  })
})
