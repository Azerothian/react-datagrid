datagrid = require "../index"
React = require "react"

{input} = React.DOM

props = {
  columns: [
    { ref:"firstname", header: "First Name", element: input, props: {} }
    { ref:"lastname", header: "Last Name", element: input, props: {} }
  ]
}



el = document.getElementById "react"
component = React.renderComponent datagrid(props), el
