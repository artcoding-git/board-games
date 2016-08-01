angular.module("app").factory "UgolkiPiece", ["Piece", (Piece) ->

  class UgolkiPiece extends Piece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector

    availableMovesWithLastOne: (lastMoveCell) ->
      result = []
      continueMove = lastMoveCell? or (point = @game.history.currentPoint()).movePlayer is point.currentPlayer
      lastMoveCell = @game.cells[point.move.to.row][point.move.to.column] if continueMove and not lastMoveCell?
      return result if continueMove and @cell isnt lastMoveCell
      unless continueMove
        result.push cell if (cell = @cell.toLeft())? and not cell.piece()?
        result.push cell if (cell = @cell.toRight())? and not cell.piece()?
        result.push cell if (cell = @cell.up())? and not cell.piece()?
        result.push cell if (cell = @cell.down())? and not cell.piece()?
      result.push cell if (cell = (nextCell = @cell.toLeft())?.toLeft())? and nextCell.piece()? and not cell.piece()?
      result.push cell if (cell = (nextCell = @cell.toRight())?.toRight())? and nextCell.piece()? and not cell.piece()?
      result.push cell if (cell = (nextCell = @cell.up())?.up())? and nextCell.piece()? and not cell.piece()?
      result.push cell if (cell = (nextCell = @cell.down())?.down())? and nextCell.piece()? and not cell.piece()?
      result

    availableMoves: ->
      result = @availableMovesWithLastOne()
      if (point = @game.history.currentPoint()).movePlayer is point.currentPlayer
        result.splice result.indexOf(@game.cells[point.move.from.row][point.move.from.column]), 1
      result

    move: (newCell) ->
      distance = @distanceTo newCell
      super
      distance is 1 or (move for move in @availableMovesWithLastOne @cell when @distanceTo(move) is 2).length is 1

    distanceTo: (newCell) ->
      Math.abs(newCell.row - @cell.row) + Math.abs(newCell.column - @cell.column)
]