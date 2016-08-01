angular.module("app").factory "CheckerKing", ["CheckerPiece", "players", (CheckerPiece, players) ->

  class CheckerKing extends CheckerPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    pieceAvailableMoves: ->
      result = super
      return result unless @cell?

      for enemyCount in [1..0]
        continue if result.length
        cell = @cell
        while (cell = cell.up()?.toLeft())?
          result.push cell if not cell.piece() and (enemy = @piecesBefore(cell)).length is enemyCount and enemy[0]?.player isnt @player
        cell = @cell
        while (cell = cell.up()?.toRight())?
          result.push cell if not cell.piece() and (enemy = @piecesBefore(cell)).length is enemyCount and enemy[0]?.player isnt @player
        cell = @cell
        while (cell = cell.down()?.toLeft())?
          result.push cell if not cell.piece() and (enemy = @piecesBefore(cell)).length is enemyCount and enemy[0]?.player isnt @player
        cell = @cell
        while (cell = cell.down()?.toRight())?
          result.push cell if not cell.piece() and (enemy = @piecesBefore(cell)).length is enemyCount and enemy[0]?.player isnt @player
      result
]