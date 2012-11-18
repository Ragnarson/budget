function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
}

function set_budget_amount() {
    var sum = 0.0;
    $('.expense_amount input.currency').each(function() {
        sum += parseFloat($(this).val().replace(',','.'));
    });
    $('#total_amount').text(sum.toFixed(2));
}

function amount_change_listener() {
    $('.expense_amount input.currency').change(function() {
        set_budget_amount();
    });
}

$(document).ready(function () {
    var budget_amount = $('#budget_amount');
    var total_header =  $('#total_header');
    var plan_budget_link = $('#plan_budget_link');
    var add_expense_link = $('#add_expense_link');

    add_expense_link.hide();
    total_header.hide();

    plan_budget_link.click(function() {
        add_expense_link.show();
        plan_budget_link.hide();
        budget_amount.hide();
        total_header.show();
        $('#total_amount').text('0');
        clear_input_currency();
        amount_change_listener();
        set_date_picker();
    });

    add_expense_link.click(function() {
        clear_input_currency();
        amount_change_listener();
        set_date_picker();
    });

    if($('#budget_plan').children().size()>0) {
        budget_amount.hide();
        total_header.show();
        add_expense_link.show();
        plan_budget_link.hide();
        clear_input_currency();
        amount_change_listener();
        set_budget_amount();
    }
});