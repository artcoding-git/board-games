// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("app").factory("ReversiPiece", [
    "Piece", function(Piece) {
      var ReversiPiece;
      return ReversiPiece = (function(_super) {
        __extends(ReversiPiece, _super);

        ReversiPiece.$inject = ["$injector"];

        function ReversiPiece($injector) {
          this.$injector = $injector;
          ReversiPiece.__super__.constructor.call(this, this.$injector);
        }

        ReversiPiece.prototype.availableMoves = function() {
          var cell, dirX, dirY, result, row, _i, _j;
          result = ReversiPiece.__super__.availableMoves.apply(this, arguments);
          for (dirX = _i = -1; _i <= 1; dirX = ++_i) {
            for (dirY = _j = -1; _j <= 1; dirY = ++_j) {
              if (((cell = (row = this.enemyRow(dirX, dirY))[row.length - 1]) != null) && (cell.piece() == null)) {
                result.push(cell);
              }
            }
          }
          return result;
        };

        ReversiPiece.prototype.canAttackMoves = function() {
          var cell, dirX, dirY, enemy, move, result, row, _i, _j, _k, _l, _len, _len1, _ref, _ref1, _ref2;
          result = ReversiPiece.__super__.canAttackMoves.apply(this, arguments);
          enemy = this.game.enemy(this.player);
          _ref = this.availableMoves();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            move = _ref[_i];
            for (dirX = _j = -1; _j <= 1; dirX = ++_j) {
              for (dirY = _k = -1; _k <= 1; dirY = ++_k) {
                if (((_ref1 = (row = this.enemyRow(dirX, dirY, move))[row.length - 1]) != null ? (_ref2 = _ref1.piece()) != null ? _ref2.player : void 0 : void 0) === this.player) {
                  for (_l = 0, _len1 = row.length; _l < _len1; _l++) {
                    cell = row[_l];
                    if (cell.piece().player === enemy && !~result.indexOf(cell)) {
                      result.push(cell);
                    }
                  }
                }
              }
            }
          }
          return result;
        };

        ReversiPiece.prototype.move = function(newCell) {
          var cell, dirX, dirY, enemy, newPiece, piece, row, _i, _j, _k, _len, _ref, _ref1;
          enemy = this.game.enemy(this.player);
          for (dirX = _i = -1; _i <= 1; dirX = ++_i) {
            for (dirY = _j = -1; _j <= 1; dirY = ++_j) {
              if (((_ref = (row = this.enemyRow(dirX, dirY, newCell))[row.length - 1]) != null ? (_ref1 = _ref.piece()) != null ? _ref1.player : void 0 : void 0) === this.player) {
                for (_k = 0, _len = row.length; _k < _len; _k++) {
                  cell = row[_k];
                  cell.piece().player = this.player;
                }
              }
            }
          }
          newPiece = this.$injector.instantiate(ReversiPiece);
          newPiece.init(this.game, this.player, this.cell);
          this.game.pieces.push(newPiece);
          ReversiPiece.__super__.move.apply(this, arguments);
          return ((function() {
            var _l, _len1, _ref2, _results;
            _ref2 = this.game.pieces;
            _results = [];
            for (_l = 0, _len1 = _ref2.length; _l < _len1; _l++) {
              piece = _ref2[_l];
              if (piece.player === enemy) {
                _results.push(piece);
              }
            }
            return _results;
          }).call(this)).some(function(piece) {
            return piece.availableMoves().length;
          });
        };

        ReversiPiece.prototype.enemyRow = function(dirX, dirY, startCell) {
          var cell, enemy, result, _ref, _ref1, _ref2, _ref3;
          if (dirX === 0 && dirY === 0) {
            return [];
          }
          enemy = this.game.enemy(this.player);
          result = [];
          cell = startCell || this.cell;
          while ((_ref1 = cell.row + dirY, __indexOf.call([0, 1, 2, 3, 4, 5, 6, 7], _ref1) >= 0) && (_ref2 = cell.column + dirX, __indexOf.call([0, 1, 2, 3, 4, 5, 6, 7], _ref2) >= 0)) {
            cell = this.game.cells[cell.row + dirY][cell.column + dirX];
            if (((_ref = cell.piece()) != null ? _ref.player : void 0) === enemy) {
              result.push(cell);
            } else {
              break;
            }
          }
          if (result.length === 0 || ((_ref3 = cell.piece()) != null ? _ref3.player : void 0) === enemy) {
            return [];
          }
          result.push(cell);
          return result;
        };

        return ReversiPiece;

      })(Piece);
    }
  ]);

}).call(this);

//# sourceMappingURL=ReversiPiece.map
