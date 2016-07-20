@IncomeApi = () ->
  this.endpoint = '/incomes'

  this.index = (success, error) =>
    $.ajax({
      url: this.endpoint,
      type: 'GET',
      dataType: 'json',
      success: success,
      error:   error
    })

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
