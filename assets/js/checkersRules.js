// Generated by CoffeeScript 1.7.1
(function() {
  var CheckersRules;

  angular.module("app").service("checkersRules", CheckersRules = (function() {
    CheckersRules.$inject = ["players", "Checker"];

    function CheckersRules(players, Checker) {
      var i;
      this.initialPieces = ((function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; _i <= 11; i = ++_i) {
          _results.push({
            player: players.white,
            pieceType: Checker,
            row: 5 + parseInt(i / 4),
            column: (i % 4) * 2 + parseInt(i / 4) % 2
          });
        }
        return _results;
      })()).concat((function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; _i <= 11; i = ++_i) {
          _results.push({
            player: players.black,
            pieceType: Checker,
            row: parseInt(i / 4),
            column: (i % 4) * 2 + 1 - parseInt(i / 4) % 2
          });
        }
        return _results;
      })());
      this.firstPlayer = players.white;
      this.manualEndTurn = function(game) {
        return false;
      };
      this.message = function(game) {
        if (game.pieces.some((function(_this) {
          return function(piece) {
            return (piece.cell != null) && piece.player === game.currentPlayer && piece.canAttackMoves().length;
          };
        })(this))) {
          return "Must eat";
        }
        return null;
      };
      this.winner = function(game) {
        var activePlayers, activePlayersEnum, key, piece, value, _i, _len, _ref;
        activePlayersEnum = {};
        _ref = game.pieces;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          piece = _ref[_i];
          if (piece.availableMoves().length) {
            activePlayersEnum[piece.player] = 1;
          }
        }
        activePlayers = (function() {
          var _results;
          _results = [];
          for (key in activePlayersEnum) {
            value = activePlayersEnum[key];
            _results.push(key);
          }
          return _results;
        })();
        if (activePlayers.length === 1) {
          return activePlayers[0];
        }
        return void 0;
      };
    }

    return CheckersRules;

  })());

}).call(this);

//# sourceMappingURL=checkersRules.map
