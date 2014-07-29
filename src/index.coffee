React = require "react"
{Table} = require "react-bootstrap"
{div, thead, tbody, th, td, tr} = React.DOM


row = React.createClass {
  getDefaultProps:->
    {
      columns: []
      rowData: {}
    }

  render: ->
    col = []
    for column in @props.columns
      props = {}
      props = clone(column.props) if column.props?
      props.value = row[column.ref] if row[column.ref]?
      col.push td({}, column.element(props))

    tr {}, columns

}


module.exports = React.createClass {
  getDefaultProps:->
    {
      columns: []
      minRowCount: 0
    }
  getInitialState: ->
    {
      rowData: []
    }
  getData: ->

  render: ->
    @transferPropsTo Table {},
      thead {},
        @props.template.map (element) ->
          th {}, element.name
      @createRows()

  createRows: ->
    rows = []
    if @state.rowData.length < 1
      return "No Data Found"
    for row in rowData
      rows.push row { columns: @props.columns, rowData: row }
    tbody {}, rows

}

clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = clone obj[key]

  return newInstance
