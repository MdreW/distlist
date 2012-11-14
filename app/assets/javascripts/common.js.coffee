# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("select#email_idlog").live "change", ->
    if $('select#email_idlog').val().length != 0
      $(this).closest("form").submit()

