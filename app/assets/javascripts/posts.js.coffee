# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.btn.btn-danger, .btn.btn-success').pjax('[data-pjax-container]');
  $('.pagination a').pjax('[data-pjax-container]');
  $('.ordem_asc').pjax('[data-pjax-container]');
  $('.ordem_desc').pjax('[data-pjax-container]');
  $('.dropdown-menu li a').pjax('[data-pjax-container]');
  $('.btn-primary').pjax('[data-pjax-container]');
  $('.nav-tabs').tab('show');
  $('.calendar').datepicker(
	 	dayNames:['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sabádo'],
  	changeMonth: true,
    changeYear: true,
    yearRange: '1930:2020',
    dateFormat: 'YY-mm-dd',
    dayNamesMin:['D','S','T','Q','Q','S','S',],
    dayNamesShort:['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    monthNames:['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro' ],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText:'Próximo',
    prevText:'Anterior'
 	);


  
