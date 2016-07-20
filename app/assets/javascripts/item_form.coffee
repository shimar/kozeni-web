ItemForm = () ->
  this.incomeApi     = new IncomeApi()
  this.outgoApi      = new OutgoApi()
  this.categoryApi   = new CategoryApi()
  this.form          = $('#new_item_form')
  this.dateField     = $('#item_form_date')
  this.categoryField = $('#item_form_category')
  this.amountField   = $('#item_form_amount')

  this.init = () ->
    this.dateField.datetimepicker()
    this.form.on('submit', this.onSubmit)
    this.categoryField.on('keyup', this.onCategoryChanged)
    this.incomeApi.index((data) ->
      data = {
        labels: data.categories,
        datasets: [
          data: data.amounts
        ]
      }
      options = {
        legend: {
          position: 'bottom'
        }
      }
      ctx = $('#income-chart')
      chart = new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options
      })
    , (data) ->
      console.log(data)
    )
    this.outgoApi.index((data) ->
      data = {
        labels: data.categories,
        datasets: [
          data: data.amounts
        ]
      }
      options = {
        legend: {
          position: 'bottom'
        }
      }
      ctx = $('#outgo-chart')
      chart = new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options
      })
    , (data) ->
      console.log(data)
    )


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
    $('#new_item_form div.alert').remove()
    block = $('<div class="alert alert-danger"></div>')
    errors = $('<ul></ul>');
    res = $.parseJSON(xhr.responseText)
    $.each(res.errors, (v) ->
      errors.append('<li>' + res.errors[v] + '</li>')
    )
    block.append(errors)
    $('#new_item_form').prepend(block)

  this.onCategoryChanged = (e) =>
    value = $(e.target).val()
    if value is ""
      categories = $('#categories-dropdown')
      categories.html('')
      categories.hide()
      return
    this.categoryApi.get(value, this.onSuccessGetCategories, this.onErrorGetCategories)

  this.onSuccessGetCategories = (data) =>
    categories = $('#categories-dropdown')
    categories.html('')
    categories.hide()
    applyCategory = this.applyCategory
    $.each(data, () ->
      item = $('<li></li>')
      anchor = $('<a href="#">' + this.name + '</a>')
      anchor.on('click', applyCategory)
      item.append(anchor)
      categories.append(item)
    )
    categories.show()
    
  this.onErrorGetCategories = (xhr, status, error) =>
    categories = $('#categories-dropdown')
    categories.html('')
    categories.hide()
    console.log(status)

  this.applyCategory = (e) =>
    this.categoryField.val($(e.target).text())
    $('#categories-dropdown').hide()
    # this.categoryField.val()

  return this

$ ->
  itemForm = new ItemForm()
  itemForm.init()
