# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.btn.btn-danger, .btn.btn-success').pjax('[data-pjax-container]')
  $('.pagination a').pjax('[data-pjax-container]')
  $('.ordem_asc').pjax('[data-pjax-container]')
  $('.ordem_desc').pjax('[data-pjax-container]')
  $('.dropdown-menu li a').pjax('[data-pjax-container]')
  $('.btn-primary').pjax('[data-pjax-container]')