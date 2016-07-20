# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@CategoryApi = () ->
  this.endpoint = '/categories'
  this.get = (value, success, error) =>
    $.ajax({
      url: this.endpoint,
      type: 'GET',
      dataType: 'json',
      data: {q: value},
      success: success,
      error: error
    })
  return this
