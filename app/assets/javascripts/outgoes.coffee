@OutgoApi = () ->
  this.endpoint = '/outgoes'
  this.create = (form, success, error) =>
    $.ajax({
      url: this.endpoint,
      type: 'POST',
      dataType: 'json',
      data: form.serializeArray(),
      success: success,
      error:   error
    })
  return this

