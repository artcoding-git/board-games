// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  angular.module("app").factory("CheckerPiece", [
    "Piece", function(Piece) {
      var CheckerPiece;
      return CheckerPiece = (function(_super) {
        __extends(CheckerPiece, _super);

        CheckerPiece.$inject = ["$injector"];

        function CheckerPiece($injector) {
          CheckerPiece.__super__.constructor.call(this, $injector);
        }

        CheckerPiece.prototype.pieceAvailableMoves = function() {
          return [];
        };

        CheckerPiece.prototype.availableMoves = function() {
          if (this.canAttackMoves().length === 0 && this.game.pieces.some((function(_this) {
            return function(piece) {
              return (piece.cell != null) && piece.player === _this.player && piece.canAttackMoves().length;
            };
          })(this))) {
            return [];
          }
          return this.pieceAvailableMoves();
        };

        CheckerPiece.prototype.canAttackMoves = function() {
          var enemy, move, result, _i, _j, _len, _len1, _ref, _ref1;
          result = [];
          _ref = this.pieceAvailableMoves();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            move = _ref[_i];
            _ref1 = this.piecesBefore(move);
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              enemy = _ref1[_j];
              if (!~result.indexOf(enemy.cell)) {
                result.push(enemy.cell);
              }
            }
          }
          return result;
        };

        CheckerPiece.prototype.move = function(newCell) {
          var enemies, piece, _i, _len;
          enemies = this.piecesBefore(newCell);
          for (_i = 0, _len = enemies.length; _i < _len; _i++) {
            piece = enemies[_i];
            piece.cell = null;
          }
          CheckerPiece.__super__.move.apply(this, arguments);
          return enemies.length === 0 || this.cannotContinueMove();
        };

        CheckerPiece.prototype.piecesBefore = function(targetCell) {
          var cell, cell1, cell2, cellColumn, cellRow, result, _i, _ref, _ref1;
          cell1 = this.cell;
          cell2 = targetCell;
          if (!((cell1 != null) && (cell2 != null))) {
            return [];
          }
          result = [];
          for (cellRow = _i = _ref = cell1.row, _ref1 = cell2.row; _ref <= _ref1 ? _i < _ref1 : _i > _ref1; cellRow = _ref <= _ref1 ? ++_i : --_i) {
            if (!(cellRow !== cell1.row)) {
              continue;
            }
            cellColumn = cell1.column + (cellRow - cell1.row) / (cell2.row - cell1.row) * (cell2.column - cell1.column);
            cell = this.game.cells[cellRow][cellColumn];
            if (cell.piece() != null) {
              result.push(cell.piece());
            }
          }
          return result;
        };

        CheckerPiece.prototype.cannotContinueMove = function() {
          return this.canAttackMoves().length === 0;
        };

        return CheckerPiece;

      })(Piece);
    }
  ]);

}).call(this);

//# sourceMappingURL=CheckerPiece.map
