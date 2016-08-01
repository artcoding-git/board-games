angular.module("app").factory "CheckerPiece", ["Piece", (Piece) ->

  class CheckerPiece extends Piece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    # please use this one in descendant classes, returning array of cells, which are available for moving
    pieceAvailableMoves: -> []

    # it checks, can any piece attack, if so then prevent moving other pieces (beside available for attacking)
    availableMoves: ->
      return [] if @canAttackMoves().length is 0 and @game.pieces.some (piece) => piece.cell? and piece.player is @player and piece.canAttackMoves().length
      @pieceAvailableMoves()

    canAttackMoves: ->
      result = []
      (result.push enemy.cell unless ~result.indexOf enemy.cell) for enemy in @piecesBefore(move) for move in @pieceAvailableMoves()
      result

    move: (newCell) ->
      enemies = @piecesBefore newCell
      piece.cell = null for piece in enemies
      super
      enemies.length is 0 or @cannotContinueMove()

    piecesBefore: (targetCell) ->
      cell1 = @cell
      cell2 = targetCell
      return [] unless cell1? and cell2?
      result = []
      for cellRow in [cell1.row...cell2.row] when cellRow isnt cell1.row
        cellColumn = cell1.column + (cellRow - cell1.row) / (cell2.row - cell1.row) * (cell2.column - cell1.column)
        cell = @game.cells[cellRow][cellColumn]
        result.push cell.piece() if cell.piece()?
      result

    cannotContinueMove: () ->
      @canAttackMoves().length is 0
]