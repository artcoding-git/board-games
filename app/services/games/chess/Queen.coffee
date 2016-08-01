angular.module("app").factory "Queen", ["ChessPiece", (ChessPiece) ->

  class Queen extends ChessPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    pieceAvailableMoves: ->
      result = super
      return result unless @cell?
      cell = @cell
      result.push cell while (cell = cell.toLeft())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.toRight())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.up())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.down())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.up()?.toLeft())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.up()?.toRight())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.down()?.toLeft())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      cell = @cell
      result.push cell while (cell = cell.down()?.toRight())? and not cell.piece()
      result.push cell if (cell?.piece()?.player or @player) isnt @player # add bound cell with enemy, if any
      result
]