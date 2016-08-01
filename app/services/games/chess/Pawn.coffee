angular.module("app").factory "Pawn", ["ChessPiece", "players", (ChessPiece, players) ->

  class Pawn extends ChessPiece
    @$inject: ["$injector", "Queen"]
    constructor: ($injector, @Queen) ->
      super $injector

    pieceAvailableMoves: ->
      result = super()
      return result unless @cell?
      ahead = if @player is players.white then "up" else "down"
      isInitialPosition = @player is players.white and @cell.row is 6 or @player is players.black and @cell.row is 1
      result.push @cell[ahead]() unless @cell[ahead]().piece()?
      result.push @cell[ahead]()[ahead]() if isInitialPosition and not @cell[ahead]().piece()? and not @cell[ahead]()[ahead]().piece()?
      result.push @cell[ahead]().toLeft() if (@cell[ahead]().toLeft()?.piece()?.player or @player) isnt @player
      result.push @cell[ahead]().toRight() if (@cell[ahead]().toRight()?.piece()?.player or @player) isnt @player
      result

    move: (newCell) ->
      super
      @replaceBy @Queen if @player is players.white and newCell.row is 0 or @player is players.black and newCell.row is 7
      yes
]