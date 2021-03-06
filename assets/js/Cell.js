// Generated by CoffeeScript 1.7.1
(function() {
  angular.module("app").factory("Cell", function() {
    var Cell;
    return Cell = (function() {
      function Cell() {}

      Cell.prototype.init = function(game, row, column) {
        this.game = game;
        this.row = row;
        this.column = column;
      };

      Cell.prototype.toLeft = function() {
        if (this.column > 0) {
          return this.game.cells[this.row][this.column - 1];
        }
      };

      Cell.prototype.toRight = function() {
        if (this.column < 7) {
          return this.game.cells[this.row][this.column + 1];
        }
      };

      Cell.prototype.up = function() {
        if (this.row > 0) {
          return this.game.cells[this.row - 1][this.column];
        }
      };

      Cell.prototype.down = function() {
        if (this.row < 7) {
          return this.game.cells[this.row + 1][this.column];
        }
      };

      Cell.prototype.piece = function() {
        var piece;
        return ((function() {
          var _i, _len, _ref, _results;
          _ref = this.game.pieces;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            piece = _ref[_i];
            if (piece.cell === this) {
              _results.push(piece);
            }
          }
          return _results;
        }).call(this))[0];
      };

      return Cell;

    })();
  });

}).call(this);

//# sourceMappingURL=Cell.map
