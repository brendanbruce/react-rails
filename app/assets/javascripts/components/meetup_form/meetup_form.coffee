@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"

  getInitialState: ->
    {
      title: ""
      description: ""
      date: new Date()
      seoText: null
    }

  dateChange: (newDate) ->
    @setState(date: newDate)

  fieldChanged: (fieldName, event) ->
    stateUpdate = {}
    stateUpdate[fieldName] = event.target.value
    @setState(stateUpdate)

  monthName: (monthNumberStartingFromZero) ->
    [
      "January", "February", "March", "April", "May", "June", "July",
      "August", "September", "October", "November", "December"
    ][monthNumberStartingFromZero]

  seoChanged: (seoText) ->
    @setState(seoText: seoText)

  computeDefaultSeoText: () ->
    words = @state.title.toLowerCase().split(/\s+/)
    words.push(@monthName(@state.date.getMonth()))
    words.push(@state.date.getFullYear().toString())
    words.filter( (string) -> string.trim().length > 0).join("-").toLowerCase()

  formSubmitted: (event) ->
    event.preventDefault()

    $.ajax
      url: "/meetups.json"
      type: "POST"
      dataType: "JSON"
      contentType: "application/json"
      processData: false
      data: JSON.stringify({meetup: {
        title: @state.title
        description: @state.description
        date: "#{@state.date.getFullYear()}-#{@state.date.getMonth() + 1}-#{@state.date.getDate()}"
        seo: @state.seoText || @computeDefaultSeoText()
      }})

  render: ->
    DOM.form
      onSubmit: @formSubmitted
      className: "form-horizontal"

      DOM.fieldset null,
        DOM.legend null, "New Meetup"

        window.reactComponents.formInputWithLabel
          id: "title"
          value: @state.title
          onChange: @fieldChanged.bind(null, "title")
          placeholder: "Meetup title"
          labelText: "Title"

        window.reactComponents.formInputWithLabel
          id: "description"
          value: @state.description
          onChange: @fieldChanged.bind(null, "description")
          placeholder: "Meetup description"
          labelText: "Description"
          elementType: "textarea"

        window.reactComponents.dateWithLabel
          onChange: @dateChanged
          date: @state.date

        window.reactComponents.formInputWithLabelAndReset
          id: "seo"
          value: if @state.seoText? then @state.seoText else @computeDefaultSeoText()
          onChange: @seoChanged
          placeholder: "SEO text"
          labelText: "seo"

        window.reactComponents.formButton
          id: "submit"


window.reactComponents.createNewMeetupForm = React.createFactory(CreateNewMeetupForm)

$ ->
  React.render(
    window.reactComponents.createNewMeetupForm(),
    document.getElementById("CreateNewMeetup")
  )
