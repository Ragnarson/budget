function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
}

function set_budget_amount() {
    var sum = 0.0;
    $('.expense_amount input.currency').each(function(){
        sum += parseFloat($(this).val().replace(',','.'));
    });
    $('#total_amount').text(sum.toFixed(2));
}

function amount_change_listener(){
    $('.expense_amount input.currency').change(function(){
        set_budget_amount();
    });
}

$(document).ready(function () {
    var budget_plan = $('#budget_plan');
    var budget_amount = $('#budget_amount');
    var total_header =  $('#total_header');
    var total_amount = $('#total_amount');
    var plan_add_link = $('#plan_add_link');

    total_header.hide();

    plan_add_link.click(function(){
        $(this).text("Add expense");
        budget_amount.hide();
        total_header.show();
        if(total_amount.is(':empty')){
            total_amount.text('0');
        }
        amount_change_listener();
        set_date_picker();
    });

    if(budget_plan.children().size()>0){
        plan_add_link.text("Add expense");
        budget_amount.hide();
        total_header.show();
        set_budget_amount();
        amount_change_listener();
    }
});