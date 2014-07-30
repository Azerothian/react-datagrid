React = require "react"
{Table} = require "react-bootstrap"
{div, thead, tbody, th, td, tr} = React.DOM

debug = require("debug")("react-datagrid:debug")

dataRow = React.createClass {
  getDefaultProps:->
    {
      columns: []
      initRowData: {}
    }
  getInitialState: ->
    {
      rowData: @props.initRowData || {}
    }

  render: ->
    cols = []
    for column in @props.columns
      props = {
        ref: column.name
        value: @state.rowData[column.name] if @state.rowData[column.name]?
        onChange:
      }
      rowComponent = column.row
      props = clone(rowComponent.props) if rowComponent.props?
      props.
      cols.push td({}, rowComponent.component(props))
    tr {}, cols
}




module.exports = React.createClass {
  addRow: ->
    @setState {
      rowData: [ { firstname: "test", lastname: "last" }]
    }
  getDefaultProps:->
    {
      columns: []
      initRowCount: 0
      initRowData: []
    }
  getInitialState: ->
    {
      rowData: @props.initRowData || []
      rowCount: @props.initRowCount || 0
    }

  render: ->
    @transferPropsTo Table {},
      thead {},
        @props.columns.map (col) ->
          th col.header.props || {}, col.header.text
      @createRows()

  createRows: ->
    rows = []
    if @state.rowData.length < 1
      return tr {}, td { colSpan: @props.columns.length }, "No Data Found"

    for i in [0...@state.rowData.length] by 1
      row = @state.rowData[i] || {}
      rows.push dataRow { columns: @props.columns, rowData: row }
    tbody {}, rows

  componentWillUnmount: ->
    #save existing data?


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
