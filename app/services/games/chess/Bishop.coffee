angular.module("app").factory "Bishop", ["ChessPiece", (ChessPiece) ->

  class Bishop extends ChessPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    pieceAvailableMoves: ->
      result = super
      return result unless @cell?
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