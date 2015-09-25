FormButton = React.createClass
  displayName: "FormButton"

  render: ->
    DOM.div
      className: "form-group"
      DOM.div
        className: "col-lg-10 col-lg-offset-2"
        DOM.button
          type: "submit"
          className: "btn btn-primary"
          "Save"

window.reactComponents.formButton = React.createFactory(FormButton)
