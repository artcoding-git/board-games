angular.module("app").controller "GameController",

  class GameController
    @$inject: ["$routeParams", "$injector", "$scope", "Game", "gameRules", "gameName", "players"]
    constructor: ($routeParams, $injector, $scope, Game, gameRules, @gameName, players) ->

      game = $injector.instantiate Game
      game.init @gameName, gameRules

      @currentPlayer = game.currentPlayer
      @selected = null

      @cells = ({row: row, column: column} for column in [0...8] for row in [0...8])
      @rowNames = (String i for i in [8..1])
      @columnNames = "abcdefgh".split ""

      @pieces = []
      updatePieces = =>
        @deadPieces = []
        (cell.piece = null for cell in row) for row in @cells
        for gamePiece, i in game.pieces
          piece = (piece for piece in @pieces when piece.index is i)[0]
          if gamePiece.cell?
            unless piece?
              piece = index: i
              @pieces.push piece
            cell = @cells[gamePiece.cell.row][gamePiece.cell.column]
            cell.piece = piece
            piece.kind = gamePiece.constructor.name
            piece.player = gamePiece.player
            piece.canMove = gamePiece.availableMoves().length > 0
            piece.cell = cell
          else
            @pieces.splice @pieces.indexOf(piece), 1 if piece?
            @deadPieces.push
              kind: gamePiece.constructor.name
              player: gamePiece.player
              index: i
        for piece in @pieces when piece.index >= game.pieces.length
          @pieces.splice @pieces.indexOf(piece), 1
      updatePieces()

      @playerColor = (player) ->
        (key for key, value of players when value is player)[0]

      @setSelected = (cell) ->
        @selected =
          cell: cell
          piece: cell?.piece
          availableMoves: []
          canAttackMoves: []
        if @selected.piece?
          gamePiece = game.pieces[@selected.piece.index]
          @selected.availableMoves = (@cells[move.row][move.column] for move in gamePiece.availableMoves())
          @selected.canAttackMoves = (@cells[move.row][move.column] for move in gamePiece.canAttackMoves())
      @setSelected null

      @cellClick = (cell) ->
        return unless game.winner() is undefined
        if ~@selected.availableMoves.indexOf cell
          game.move @selected.cell.row, @selected.cell.column, cell.row, cell.column
          update @currentPlayer isnt game.currentPlayer
          @setSelected cell if @selected.cell?
        else
          @setSelected cell if cell.piece?.player is @currentPlayer

      @dropped = (pieceId, cellId) ->
        cellEl = angular.element document.getElementById cellId
        cell = @cells[Number cellEl.attr "ng-cell-row"][Number cellEl.attr "ng-cell-column"]
        @cellClick cell
        $scope.$apply()

      @endTurn = ->
        game.endTurn()
        update()

      @manualEndTurn = ->
        game.manualEndTurn()

      @gameMessage = ->
        game.message()

      @gameOverMessage = ->
        winner = game.winner()
        switch winner
          when undefined then ""
          when null then "Game over. Draw game."
          else "Game over. Winner: #{@playerColor(winner)}"

      @prevMove = ->
        game.history.back()
        update()

      @nextMove = ->
        game.history.forward()
        update()

      @canPrevMove = ->
        game.history.currentPointIndex > 0

      @canNextMove = ->
        game.history.currentPointIndex < game.history.points.length - 1

      @lastMove = ->
        move = game.history.currentPoint().move
        "#{@columnNames[move.from.column]}#{@rowNames[move.from.row]} - #{@columnNames[move.to.column]}#{@rowNames[move.to.row]}" if move?

      update = (resetSelected = yes) =>
        @currentPlayer = game.currentPlayer
        @setSelected null if resetSelected
        updatePieces()
