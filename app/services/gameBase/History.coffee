angular.module("app").factory "History", ->

  class Game
    @$inject: ["$injector"]
    constructor: (@$injector) ->
      @points = []
      @currentPointIndex = null

    init: (@game) ->

    savePoint: (movePlayer, move) ->
      @cropToCurrent()
      @points.push
        currentPlayer: @game.currentPlayer
        pieces: for piece, i in @game.pieces
          row: piece.cell?.row
          column: piece.cell?.column
          type: piece.constructor
          player: piece.player
          index: i
        movePlayer: movePlayer
        move: move
        time: new Date()
      @currentPointIndex = @points.length - 1

    navigate: (pointIndex) ->
      return unless pointIndex in [0...@points.length]
      @currentPointIndex = pointIndex
      point = @points[@currentPointIndex]
      @game.currentPlayer = point.currentPlayer
      for piece in point.pieces
        gamePiece = @game.pieces[piece.index]
        cell = if piece.row? then @game.cells[piece.row][piece.column] else null
        unless gamePiece?
          gamePiece = @$injector.instantiate piece.type
          gamePiece.init @game, piece.player, cell
          @game.pieces.push gamePiece
        gamePiece.cell = cell
        gamePiece.player = piece.player
        gamePiece.replaceBy piece.type if gamePiece.constructor.name isnt piece.type.name
      for gamePiece, index in @game.pieces when (point.pieces.every (piece) -> piece.index isnt index)
        @game.pieces.splice @game.pieces.indexOf(gamePiece), 1

    back: ->
      @navigate @currentPointIndex - 1

    forward: ->
      @navigate @currentPointIndex + 1

    cropToCurrent: ->
      @points.length = @currentPointIndex + 1 if @currentPointIndex?

    currentPoint: ->
        @points[@currentPointIndex]