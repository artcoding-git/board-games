angular.module("app").service "reversiRules",

  class ReversiRules
    @$inject: ["players", "ReversiPiece"]
    constructor: (players, ReversiPiece) ->

      @initialPieces = [
        {player: players.white, pieceType: ReversiPiece, row: 3, column: 3 }
        {player: players.black, pieceType: ReversiPiece, row: 3, column: 4 }
        {player: players.black, pieceType: ReversiPiece, row: 4, column: 3 }
        {player: players.white, pieceType: ReversiPiece, row: 4, column: 4 }
      ]

      @firstPlayer = players.white

      @manualEndTurn = (game) ->
        no

      @message = (game) ->
        null

      @winner = (game) ->
        if (game.pieces.every (piece) -> piece.availableMoves().length is 0)
          pieceCount = {}
          pieceCount[player] = 0 for playerColor, player of players
          pieceCount[piece.player]++ for piece in game.pieces
          maxPieceCount = Math.max (count for player, count of pieceCount)...
          winners = (player for player, count of pieceCount when count is maxPieceCount)
          return if winners.length is 1 then winners[0] else null
        undefined
