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
//= require_tree .
//= require jquery.pjax
//= require fancyzoom/jquery.fancyzoom
//= require twitter/bootstrap


$(document).ready(function(){
	setTimeout(function(){
		$('.alert.alert-success, .alert.alert-error, .alert.alert-warning').slideUp('fast');
	}, 5000)

	$('.last').css('float','right');

  jQuery.fn.reset = function () {
    $(this).each (function() { this.reset(); });
  }

 $("#form_contact").submit(function(){
    $.each($('#form_contact .required'), function() {
        if ($(this).val() == '') { $error = 1; }
    });
    if($error > 0){
        $.each($('#form_contact .required'), function(){
            if($(this).val() == ''){
                $(this).parent().addClass('control-group error');
                $mensagem = "Atenção! Preencha corretamente os campos em vermelho!"
            }
            else{
                $(this).removeClass('error');
            };
        });
        $error = 0;
        alert($mensagem);
        return false;
    }
    return true;
    });


$("#new_comment").submit(function(){
    $.each($('#new_comment .required'), function() {
        if ($(this).val() == '') { $error = 1; }
    });
    if($error > 0){
        $.each($('#new_comment .required'), function(){
            if($(this).val() == ''){
                $(this).parent().addClass('control-group error');
                $mensagem = "Atenção! Preencha corretamente os campos em vermelho!"
            }
            else{
                $(this).removeClass('error');
            };
        });
        $error = 0;
        alert($mensagem);
        return false;
    }
    return true;
    });

    $.fn.fancyzoom.defaultsOptions.imgDir= '/images/';

// Select all links in object with gallery ID using the defaults options
    $('.gallery a').fancyzoom(); 

})
