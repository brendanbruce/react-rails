window.DOM = React.DOM

@FormInputWithLabel = React.createClass
  displayName: "FormInputWithLabel"

  getDefaultProps: ->
    elementType: "input"
    inputType: "text"

  tagType: ->
    {
      "input": @props.inputType,
      "textarea": null
    }[@props.elementType]

  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        htmlFor: @props.id
        className: "col-lg-2 control-label"
        @props.labelText
      DOM.div
        className: "col-lg-10"
        DOM[@props.elementType]
          className: "form-control"
          placeholder: @props.placeholder
          id: @props.id
          type: @tagType()
          value: @props.value
          onChange: @props.onChange


formInputWithLabel = React.createFactory(FormInputWithLabel)

@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"

  getInitialState: ->
    {
      title: ""
      description: ""
      date: new Date()
    }

  dateChange: (newDate) ->
    @setState(date: newDate)

  fieldChanged: (fieldName, event) ->
    stateUpdate = {}
    stateUpdate[fieldName] = event.target.value
    @setState(stateUpdate)

  formSubmitted: (event) ->
    event.preventDefault()

    $.ajax
      url: "/meetups.json"
      type: "POST"
      dataType: "JSON"
      contentType: "application/json"
      processData: false
      data: JSON.stringify({
        meetup: @state
      })

  render: ->
    DOM.form
      onSubmit: @formSubmitted
      className: "form-horizontal"

      DOM.fieldset null,
        DOM.legend null, "New Meetup"

        formInputWithLabel
          id: "title"
          value: @state.title
          onChange: @fieldChanged.bind(null, "title")
          placeholder: "Meetup title"
          labelText: "Title"

        formInputWithLabel
          id: "description"
          value: @state.description
          onChange: @fieldChanged.bind(null, "description")
          placeholder: "Meetup description"
          labelText: "Description"
          elementType: "textarea"

        window.dateWithLabel
          onChange: @dateChanged
          date: @state.date

        DOM.div
          className: "form-group"
          DOM.div
            className: "col-lg-10 col-lg-offset-2"
            DOM.button
              type: "submit"
              className: "btn btn-primary"
              "Save"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)

$ ->
  React.render(
    createNewMeetupForm(),
    document.getElementById("CreateNewMeetup")
  )
