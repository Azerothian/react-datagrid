datagrid = require "../index"
React = require "react"
d = require("debug")
d.enable("*")
debug = d("debug:react-datagrid:test:test")
{input} = React.DOM

props = {
  columns: [{
    name: "firstname"
    header:
      props: {}
      text:  "First Name"
    row:
      component: input
      props: {}
  }, {
    name: "lastname"
    header:
      props: {}, text:  "Last Name"
    row:
      component: input
      props: {}
  }]

}





el = document.getElementById "react"
grid = datagrid(props)

debug "grid", grid
component = React.renderComponent grid, el
component.addRow()


###
grid.setData [
  { firstname: "first", lastname: "last" }
]
###
