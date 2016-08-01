angular.module("app").factory "ChessPiece", ["Piece", (Piece) ->

  class ChessPiece extends Piece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    # please use this one in descendant classes, returning array of cells, which are available for moving
    pieceAvailableMoves: -> []

    # it checks, is there check, if so then prevent any move beside avoiding check moves
    availableMoves: ->
      result = []
      for newCell in @pieceAvailableMoves()
        @game.move @cell.row, @cell.column, newCell.row, newCell.column, no
        result.push newCell unless @game.gameRules.isCheck @game, @player
        @game.history.navigate @game.history.currentPointIndex
      result

    # returns array of available moves attacking enemy, independending on check to king
    pieceCanAttackMoves: ->
      @pieceAvailableMoves().filter (cell) -> (cell.piece()?.player or @player) isnt @player

    # returns array of available moves attacking enemy, preventing check (if any)
    canAttackMoves: ->
      @availableMoves().filter (cell) -> (cell.piece()?.player or @player) isnt @player

    move: (newCell) ->
      newCell.piece()?.cell = null # kill enemy's piece
      super
      yes

    unmove: (oldCell) ->
      @cell = oldCell

]