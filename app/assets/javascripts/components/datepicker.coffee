DateWithLabel = React.createClass
  getDefaultProps: ->
    date: new Date()
  onYearChange: (event) ->
    newDate = new Date(
      event.target.value,
      @props.date.getMonth(),
      @props.date.getDate()
    )
    @props.onChange(newDate)
  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        className: "col-lg-2 control-label"
        "Date"
      DOM.div
        className: "col-lg-2"
        DOM.select
          className: "form-control"
          value: @props.date.getFullYear()
          DOM.option(value: year, key: year, year) for year in [2015..2020]

window.dateWithLabel = React.createFactory(DateWithLabel)
