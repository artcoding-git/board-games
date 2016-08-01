angular.module("app").factory "Checker", ["CheckerPiece", "players", (CheckerPiece, players) ->

  class Checker extends CheckerPiece
    @$inject: ["$injector", "CheckerKing"]
    constructor: ($injector, @CheckerKing) ->
      super $injector

    pieceAvailableMoves: ->
      result = super
      return result unless @cell?

      result.push cell if (enemy = @piecesBefore (cell = @cell.up()?.up()?.toLeft()?.toLeft())).length is 1 and enemy[0].player isnt @player and not cell.piece()
      result.push cell if (enemy = @piecesBefore (cell = @cell.up()?.up()?.toRight()?.toRight())).length is 1 and enemy[0].player isnt @player and not cell.piece()
      result.push cell if (enemy = @piecesBefore (cell = @cell.down()?.down()?.toLeft()?.toLeft())).length is 1 and enemy[0].player isnt @player and not cell.piece()
      result.push cell if (enemy = @piecesBefore (cell = @cell.down()?.down()?.toRight()?.toRight())).length is 1 and enemy[0].player isnt @player and not cell.piece()

      if result.length is 0
        ahead = if @player is players.white then "up" else "down"
        result.push cell if (cell = (@cell[ahead]())?.toLeft())? and not cell.piece()?
        result.push cell if (cell = (@cell[ahead]())?.toRight())? and not cell.piece()?

      result

    move: (newCell) ->
      enemies = @piecesBefore newCell
      super
      @replaceBy @CheckerKing if @player is players.white and newCell.row is 0 or @player is players.black and newCell.row is 7
      enemies.length is 0 or @cannotContinueMove()
]