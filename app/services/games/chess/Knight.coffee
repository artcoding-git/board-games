angular.module("app").factory "Knight", ["ChessPiece", (ChessPiece) ->

  class Knight extends ChessPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    pieceAvailableMoves: ->
      result = super
      return result unless @cell?
      result.push cell if (cell = @cell.up()?.up()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up()?.up()?.toRight())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up()?.toLeft()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up()?.toRight()?.toRight())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.down()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.down()?.toRight())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.toLeft()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.toRight()?.toRight())? and cell.piece()?.player isnt @player
      result
]