angular.module("app").service "chessRules",

  class ChessRules
    @$inject: ["players", "ChessPiece", "King", "Queen", "Rook", "Bishop", "Knight", "Pawn"]
    constructor: (players, ChessPiece, King, Queen, Rook, Bishop, Knight, Pawn) ->

      @initialPieces =
        [
          { player: players.white, row: 7, column: 4, pieceType: King }
          { player: players.white, row: 7, column: 3, pieceType: Queen }
          { player: players.white, row: 7, column: 0, pieceType: Rook }
          { player: players.white, row: 7, column: 7, pieceType: Rook }
          { player: players.white, row: 7, column: 2, pieceType: Bishop }
          { player: players.white, row: 7, column: 5, pieceType: Bishop }
          { player: players.white, row: 7, column: 1, pieceType: Knight }
          { player: players.white, row: 7, column: 6, pieceType: Knight }
        ].concat \
        (player: players.white, row: 6, column: i, pieceType: Pawn for i in [0..7]).concat \
        [
          { player: players.black, row: 0, column: 4, pieceType: King }
          { player: players.black, row: 0, column: 3, pieceType: Queen }
          { player: players.black, row: 0, column: 0, pieceType: Rook }
          { player: players.black, row: 0, column: 7, pieceType: Rook }
          { player: players.black, row: 0, column: 2, pieceType: Bishop }
          { player: players.black, row: 0, column: 5, pieceType: Bishop }
          { player: players.black, row: 0, column: 1, pieceType: Knight }
          { player: players.black, row: 0, column: 6, pieceType: Knight }
        ].concat \
        (player: players.black, row: 1, column: i, pieceType: Pawn for i in [0..7])

      @firstPlayer = players.white

      @manualEndTurn = (game) ->
        no

      @message = (game) ->
        hasAvailableMoves = game.pieces.some (piece) -> piece.player is game.currentPlayer and piece.availableMoves().length
        isCheck = @isCheck game
        return if hasAvailableMoves then (if isCheck then "Check!" else null) else (if isCheck then "Checkmate!" else "Stalemate!")

      @winner = (game) ->
        hasAvailableMoves = game.pieces.some (piece) -> piece.player is game.currentPlayer and piece.availableMoves().length
        if not hasAvailableMoves
          isCheck = @isCheck game
          return if isCheck then game.enemy() else null
        undefined

      @isCheck = (game, toPlayer) ->
        toPlayer = game.currentPlayer unless toPlayer?
        king = (piece for piece in game.pieces when piece.constructor.name is "King" and piece.player is toPlayer)[0]
        (~piece.pieceCanAttackMoves().indexOf king.cell for piece in game.pieces when piece.player isnt toPlayer).some (i) -> i
