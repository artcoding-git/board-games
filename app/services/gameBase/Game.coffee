angular.module("app").factory "Game", ->

  class Game
    @$inject: ["$injector", "Cell", "History", "players"]
    constructor: (@$injector, Cell, History, @players) ->
      @cells = ((cell = $injector.instantiate Cell; cell.init @, row, column; cell) for column in [0...8] for row in [0...8])
      @pieces = []
      @history = @$injector.instantiate History

    init: (@name, @gameRules) ->
      @pieces = for p in @gameRules.initialPieces
        piece = @$injector.instantiate p.pieceType
        piece.init @, p.player, (if p.row? then @cells[p.row][p.column] else null)
        piece
      @currentPlayer = @gameRules.firstPlayer
      @history.init @
      @history.savePoint null, null

    move: (srcRow, srcColumn, destRow, destColumn, saveHistoryPoint = yes) ->
      piece = @cells[srcRow][srcColumn].piece()
      return unless piece? and piece.player is @currentPlayer
      newCell = @cells[destRow][destColumn]
      movePlayer = @currentPlayer
      endTurn = piece.move newCell
      @nextPlayer() if endTurn

      if saveHistoryPoint
        @history.savePoint movePlayer,
          from:
            row: srcRow
            column: srcColumn
          to:
            row: destRow
            column: destColumn

    nextPlayer: ->
      players = (value for key, value of @players)
      @currentPlayer = players[((players.indexOf @currentPlayer) + 1) % players.length]

    endTurn: ->
      @nextPlayer()
      @history.currentPoint().currentPlayer = @currentPlayer

    message: ->
      @gameRules.message @

    winner: ->
      @gameRules.winner @

    manualEndTurn: ->
      @gameRules.manualEndTurn @

    enemies: (forPlayer) ->
      (player for playerName, player of @players when player isnt (forPlayer or @currentPlayer))

    enemy: (forPlayer) ->
      @enemies(forPlayer)[0]
