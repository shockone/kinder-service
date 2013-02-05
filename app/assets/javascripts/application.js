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
//= require jquery.effects.bounce
//= require jquery.ui.sortable
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
    $('#cart, #nav').scrollToFixed();
    $("input[value='Купити'], #buy-button").click(function () {
        $('#cart').effect("bounce", { times: 1, distance: 15, mode: 'effect' }, 200);
    });
    $('#password-related').hide();
    $('<a>', {
        text: 'Змінити пароль',
        href: '#',
        'class': 'ajax-link',
        click: function () {
            $('#password-related').toggle();
            return false;
        }}).insertBefore('#password-related');
    $('.popbox').popbox();
    var imageSlider = new mcImgSlider(sliderOptions);
    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) || window.innerWidth < 800) {
        $('#cart, #nav').trigger('remove.ScrollToFixed');
    }
    $(window).resize(function () {
        if (window.innerWidth < 800) {
            $('#cart, #nav').trigger('remove.ScrollToFixed');
        }
        else {
            if(!/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)){
                $('#cart, #nav').scrollToFixed();
            }
        }
    });


});