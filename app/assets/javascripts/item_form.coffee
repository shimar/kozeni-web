IncomeApi = () ->
  this.endpoint = '/incomes'

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

OutgoApi = () ->
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

ItemForm = () ->
  this.incomeApi     = new IncomeApi()
  this.outgoApi      = new OutgoApi()
  this.form          = $('#new_item_form')
  this.dateField     = $('#item_form_date')
  this.categoryField = $('#item_form_category')
  this.amountField   = $('#item_form_amount')

  this.init = () ->
    this.dateField.datetimepicker()
    this.form.on('submit', this.onSubmit)

  this.onSubmit = (e) =>
    e.preventDefault()
    amount = this.amountField.val()
    if amount > 0
      this.createIncome()
    else
      this.createOutgo()

  this.createIncome = () =>
    this.incomeApi.create(this.form, this.onSuccess, this.onError)

  this.createOutgo = () =>
    this.outgoApi.create(this.form, this.onSuccess, this.onError)

  this.onSuccess = (data, dataType) =>
    this.categoryField.val('')
    this.amountField.val('')

  this.onError = (xhr, status, error) =>
    console.log(status)

  return this

$ ->
  itemForm = new ItemForm()
  itemForm.init()
