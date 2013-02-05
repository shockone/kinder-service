function recalculateTotal() {
    var totalCents = 0;
    var totalDiscount = 0;
    var discountPercent = 0;
    var shippingPrice = 500;
    $('.amount-field').each(function(){
        var thisTotal = $(this).val() * $(this).data('price');
        totalCents += thisTotal;
        if ($(this).hasClass('discount')) {
            totalDiscount += thisTotal;
        }
        else {
            var description = $(this).parent().prev();
            if (description.has('span').length === 0){
                description.find('a').after('<span class="red">*</span>');
            }
        }
    });
    if (totalDiscount >= 53000) {
        discountPercent = 5;
    }
    else if (totalDiscount >= 31000) {
        discountPercent = 3;
    }
    else {
        discountPercent = 0;
    }
    if (totalCents > 10000) {
        $('#bought-items > tbody > tr:last span').text('Доставка');
        $('#shipping-price').text('безкоштовна');
        shippingPrice = 0;
    }
    else {
        $('#bought-items > tbody > tr:last span').text('Доставка (безкоштовна при замовлення на суму від 100 гривень)');
        $('#shipping-price').text('5,00 грн.');
        shippingPrice = 500;
    }
    var discount = Math.floor(totalDiscount * discountPercent / 100);
    var price = ((totalCents + shippingPrice - discount) / 100);
    $('#discount').text(discountPercent + '%');
    $("#total").text(price.toString().replace('.', ',') + ' грн.');
}
$(document).ready(function(){
    recalculateTotal();
    $('.amount-field').keypress(function(e) {
        var a = [];
        var k = e.which;

        for (i = 48; i < 58; i++)
            a.push(i);

        if (!(a.indexOf(k)>=0))
            e.preventDefault();
    });
});