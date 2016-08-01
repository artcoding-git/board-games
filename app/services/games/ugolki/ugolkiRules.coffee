angular.module("app").service "ugolkiRules",

  class UgolkiRules
    @$inject: ["players", "UgolkiPiece"]
    constructor: (players, UgolkiPiece) ->

      @initialPieces =
        ({ player: players.white, pieceType: UgolkiPiece, row: 4 + parseInt(i / 3), column: 5 + i % 3 } for i in [0...12]).concat \
        ({ player: players.black, pieceType: UgolkiPiece, row: parseInt(i / 3), column: i % 3 } for i in [0...12])

      @firstPlayer = players.white

      @manualEndTurn = (game) ->
        (point = game.history.currentPoint()).movePlayer is point.currentPlayer

      @message = (game) ->
        null

      @winner = (game) ->
        notWinners = {}
        for piece in game.pieces
          if not (piece.player is players.white and piece.cell.row < 4 and piece.cell.column < 3) and
              not (piece.player is players.black and piece.cell.row >= 4 and piece.cell.column >= 5)
            notWinners[piece.player] = 1
        (player for playerColor, player of players when notWinners[player] isnt 1)[0]
