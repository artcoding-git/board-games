angular.module("app").factory "Rook", ["ChessPiece", (ChessPiece) ->

  class Rook extends ChessPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector
      @moved = no

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
      result

    move: (newCell) ->
      @moved = yes
      super
]