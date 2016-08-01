angular.module("app").factory "ReversiPiece", ["Piece", (Piece) ->

  class ReversiPiece extends Piece
    @$inject: ["$injector"]
    constructor: (@$injector) ->
      super @$injector

    availableMoves: ->
      result = super
      for dirX in [-1..1]
        for dirY in [-1..1]
          result.push cell if (cell = (row = @enemyRow dirX, dirY)[row.length - 1])? and not cell.piece()?
      result

    canAttackMoves: ->
      result = super
      enemy = @game.enemy @player
      for move in @availableMoves()
        for dirX in [-1..1]
          for dirY in [-1..1]
            if (row = @enemyRow dirX, dirY, move)[row.length - 1]?.piece()?.player is @player
              result.push cell for cell in row when cell.piece().player is enemy and not ~result.indexOf cell
      result

    move: (newCell) ->
      enemy = @game.enemy @player
      for dirX in [-1..1]
        for dirY in [-1..1]
          if (row = @enemyRow dirX, dirY, newCell)[row.length - 1]?.piece()?.player is @player
            cell.piece().player = @player for cell in row
      newPiece = @$injector.instantiate ReversiPiece
      newPiece.init @game, @player, @cell
      @game.pieces.push newPiece
      super
      (piece for piece in @game.pieces when piece.player is enemy).some (piece) -> piece.availableMoves().length

    # Returns set of enemies in specified direction (e.g. -1, -1 means north-west direction)
    # from startCell (that is current cell by default), including the cell after enemies.
    # If there is no cell after enemies or no any enemy in specified direction, then empty array is returned.
    enemyRow: (dirX, dirY, startCell) ->
      return [] if dirX is 0 and dirY is 0
      enemy = @game.enemy @player
      result = []
      cell = startCell or @cell
      while (cell.row + dirY) in [0...8] and (cell.column + dirX) in [0...8]
        cell = @game.cells[cell.row + dirY][cell.column + dirX]
        if cell.piece()?.player is enemy
          result.push cell
        else
          break
      if result.length is 0 or cell.piece()?.player is enemy
        return []
      result.push cell
      result
]