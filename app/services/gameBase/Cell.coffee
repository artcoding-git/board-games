angular.module("app").factory "Cell", ->

  class Cell
    init: (@game, @row, @column) ->

    toLeft: ->
      @game.cells[@row][@column - 1] if @column > 0

    toRight: ->
      @game.cells[@row][@column + 1] if @column < 7

    up: ->
      @game.cells[@row - 1][@column] if @row > 0

    down: ->
      @game.cells[@row + 1][@column] if @row < 7

    piece: ->
      (piece for piece in @game.pieces when piece.cell is @)[0]