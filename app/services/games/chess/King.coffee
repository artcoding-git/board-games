angular.module("app").factory "King", ["ChessPiece", (ChessPiece) ->

  class King extends ChessPiece
    @$inject: ["$injector"]
    constructor: ($injector) ->
      super $injector
      @moved = no

    pieceAvailableMoves: ->
      result = super
      result.push cell if (cell = @cell.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.toRight())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.up()?.toRight())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.toLeft())? and cell.piece()?.player isnt @player
      result.push cell if (cell = @cell.down()?.toRight())? and cell.piece()?.player isnt @player
      if not @moved
        for rookColumn in [0, 7]
          if (rook = @game.cells[@cell.row][rookColumn].piece())? and rook.constructor.name is "Rook" and not rook.moved and
              ((@game.cells[@cell.row][i] for i in [rookColumn...@cell.column] when i isnt rookColumn).every (cell) -> not cell.piece()?)
            result.push if rookColumn < @cell.column then @cell.toLeft().toLeft() else @cell.toRight().toRight()
      result

    move: (newCell) ->
      if Math.abs(newCell.column - @cell.column) is 2
        rook = @game.cells[@cell.row][if newCell.column > @cell.column then 7 else 0].piece()
        rook.move if newCell.column < @cell.column then @cell.toLeft() else @cell.toRight()
      @moved = yes
      super
]