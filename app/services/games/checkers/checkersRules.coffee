angular.module("app").service "checkersRules",

  class CheckersRules
    @$inject: ["players", "Checker"]
    constructor: (players, Checker) ->

      @initialPieces =
        (player: players.white, pieceType: Checker, row: 5 + parseInt(i / 4), column: (i % 4) * 2 + parseInt(i / 4) % 2 for i in [0..11]).concat \
        (player: players.black, pieceType: Checker, row: parseInt(i / 4), column: (i % 4) * 2 + 1 - parseInt(i / 4) % 2 for i in [0..11])

      @firstPlayer = players.white

      @manualEndTurn = (game) ->
        no

      @message = (game) ->
        return "Must eat" if game.pieces.some (piece) => piece.cell? and piece.player is game.currentPlayer and piece.canAttackMoves().length
        null

      @winner = (game) ->
        activePlayersEnum = {}
        activePlayersEnum[piece.player] = 1 for piece in game.pieces when piece.availableMoves().length
        activePlayers = (key for key, value of activePlayersEnum)
        return activePlayers[0] if activePlayers.length is 1
        undefined
