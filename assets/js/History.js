// Generated by CoffeeScript 1.7.1
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("app").factory("History", function() {
    var Game;
    return Game = (function() {
      Game.$inject = ["$injector"];

      function Game($injector) {
        this.$injector = $injector;
        this.points = [];
        this.currentPointIndex = null;
      }

      Game.prototype.init = function(game) {
        this.game = game;
      };

      Game.prototype.savePoint = function(movePlayer, move) {
        var i, piece;
        this.cropToCurrent();
        this.points.push({
          currentPlayer: this.game.currentPlayer,
          pieces: (function() {
            var _i, _len, _ref, _ref1, _ref2, _results;
            _ref = this.game.pieces;
            _results = [];
            for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
              piece = _ref[i];
              _results.push({
                row: (_ref1 = piece.cell) != null ? _ref1.row : void 0,
                column: (_ref2 = piece.cell) != null ? _ref2.column : void 0,
                type: piece.constructor,
                player: piece.player,
                index: i
              });
            }
            return _results;
          }).call(this),
          movePlayer: movePlayer,
          move: move,
          time: new Date()
        });
        return this.currentPointIndex = this.points.length - 1;
      };

      Game.prototype.navigate = function(pointIndex) {
        var cell, gamePiece, index, piece, point, _i, _j, _k, _len, _len1, _ref, _ref1, _ref2, _results, _results1;
        if (__indexOf.call((function() {
          _results = [];
          for (var _i = 0, _ref = this.points.length; 0 <= _ref ? _i < _ref : _i > _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
          return _results;
        }).apply(this), pointIndex) < 0) {
          return;
        }
        this.currentPointIndex = pointIndex;
        point = this.points[this.currentPointIndex];
        this.game.currentPlayer = point.currentPlayer;
        _ref1 = point.pieces;
        for (_j = 0, _len = _ref1.length; _j < _len; _j++) {
          piece = _ref1[_j];
          gamePiece = this.game.pieces[piece.index];
          cell = piece.row != null ? this.game.cells[piece.row][piece.column] : null;
          if (gamePiece == null) {
            gamePiece = this.$injector.instantiate(piece.type);
            gamePiece.init(this.game, piece.player, cell);
            this.game.pieces.push(gamePiece);
          }
          gamePiece.cell = cell;
          gamePiece.player = piece.player;
          if (gamePiece.constructor.name !== piece.type.name) {
            gamePiece.replaceBy(piece.type);
          }
        }
        _ref2 = this.game.pieces;
        _results1 = [];
        for (index = _k = 0, _len1 = _ref2.length; _k < _len1; index = ++_k) {
          gamePiece = _ref2[index];
          if (point.pieces.every(function(piece) {
            return piece.index !== index;
          })) {
            _results1.push(this.game.pieces.splice(this.game.pieces.indexOf(gamePiece), 1));
          }
        }
        return _results1;
      };

      Game.prototype.back = function() {
        return this.navigate(this.currentPointIndex - 1);
      };

      Game.prototype.forward = function() {
        return this.navigate(this.currentPointIndex + 1);
      };

      Game.prototype.cropToCurrent = function() {
        if (this.currentPointIndex != null) {
          return this.points.length = this.currentPointIndex + 1;
        }
      };

      Game.prototype.currentPoint = function() {
        return this.points[this.currentPointIndex];
      };

      return Game;

    })();
  });

}).call(this);

//# sourceMappingURL=History.map