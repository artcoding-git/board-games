// Generated by CoffeeScript 1.7.1
(function() {
  angular.module("app").factory("Game", function() {
    var Game;
    return Game = (function() {
      Game.$inject = ["$injector", "Cell", "History", "players"];

      function Game($injector, Cell, History, players) {
        var cell, column, row;
        this.$injector = $injector;
        this.players = players;
        this.cells = (function() {
          var _i, _results;
          _results = [];
          for (row = _i = 0; _i < 8; row = ++_i) {
            _results.push((function() {
              var _j, _results1;
              _results1 = [];
              for (column = _j = 0; _j < 8; column = ++_j) {
                _results1.push((cell = $injector.instantiate(Cell), cell.init(this, row, column), cell));
              }
              return _results1;
            }).call(this));
          }
          return _results;
        }).call(this);
        this.pieces = [];
        this.history = this.$injector.instantiate(History);
      }

      Game.prototype.init = function(name, gameRules) {
        var p, piece;
        this.name = name;
        this.gameRules = gameRules;
        this.pieces = (function() {
          var _i, _len, _ref, _results;
          _ref = this.gameRules.initialPieces;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            p = _ref[_i];
            piece = this.$injector.instantiate(p.pieceType);
            piece.init(this, p.player, (p.row != null ? this.cells[p.row][p.column] : null));
            _results.push(piece);
          }
          return _results;
        }).call(this);
        this.currentPlayer = this.gameRules.firstPlayer;
        this.history.init(this);
        return this.history.savePoint(null, null);
      };

      Game.prototype.move = function(srcRow, srcColumn, destRow, destColumn, saveHistoryPoint) {
        var endTurn, movePlayer, newCell, piece;
        if (saveHistoryPoint == null) {
          saveHistoryPoint = true;
        }
        piece = this.cells[srcRow][srcColumn].piece();
        if (!((piece != null) && piece.player === this.currentPlayer)) {
          return;
        }
        newCell = this.cells[destRow][destColumn];
        movePlayer = this.currentPlayer;
        endTurn = piece.move(newCell);
        if (endTurn) {
          this.nextPlayer();
        }
        if (saveHistoryPoint) {
          return this.history.savePoint(movePlayer, {
            from: {
              row: srcRow,
              column: srcColumn
            },
            to: {
              row: destRow,
              column: destColumn
            }
          });
        }
      };

      Game.prototype.nextPlayer = function() {
        var key, players, value;
        players = (function() {
          var _ref, _results;
          _ref = this.players;
          _results = [];
          for (key in _ref) {
            value = _ref[key];
            _results.push(value);
          }
          return _results;
        }).call(this);
        return this.currentPlayer = players[((players.indexOf(this.currentPlayer)) + 1) % players.length];
      };

      Game.prototype.endTurn = function() {
        this.nextPlayer();
        return this.history.currentPoint().currentPlayer = this.currentPlayer;
      };

      Game.prototype.message = function() {
        return this.gameRules.message(this);
      };

      Game.prototype.winner = function() {
        return this.gameRules.winner(this);
      };

      Game.prototype.manualEndTurn = function() {
        return this.gameRules.manualEndTurn(this);
      };

      Game.prototype.enemies = function(forPlayer) {
        var player, playerName, _ref, _results;
        _ref = this.players;
        _results = [];
        for (playerName in _ref) {
          player = _ref[playerName];
          if (player !== (forPlayer || this.currentPlayer)) {
            _results.push(player);
          }
        }
        return _results;
      };

      Game.prototype.enemy = function(forPlayer) {
        return this.enemies(forPlayer)[0];
      };

      return Game;

    })();
  });

}).call(this);

//# sourceMappingURL=Game.map
