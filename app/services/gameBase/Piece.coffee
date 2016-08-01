angular.module("app").factory "Piece", ->

  class Piece
    @$inject: ["$injector"]
    constructor: (@$injector) ->

    init: (@game, @player, @cell) ->

    availableMoves: -> [] # to be overrided by descendants, returns array of cells, which are available for moving

    canAttackMoves: -> [] # to be overrided by descendants, returns array of cells, which are under attack by this piece

    move: (newCell) ->
      @cell = newCell
      yes # should player end his turn after this move

    replaceBy: (newPieceType) ->
      newPiece = @$injector.instantiate newPieceType
      newPiece.init @game, @player, @cell
      @game.pieces[@game.pieces.indexOf @] = newPiece
