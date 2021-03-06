// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  angular.module("app").factory("King", [
    "ChessPiece", function(ChessPiece) {
      var King;
      return King = (function(_super) {
        __extends(King, _super);

        King.$inject = ["$injector"];

        function King($injector) {
          King.__super__.constructor.call(this, $injector);
          this.moved = false;
        }

        King.prototype.pieceAvailableMoves = function() {
          var cell, i, result, rook, rookColumn, _i, _len, _ref, _ref1, _ref10, _ref11, _ref12, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
          result = King.__super__.pieceAvailableMoves.apply(this, arguments);
          if (((cell = this.cell.toLeft()) != null) && ((_ref = cell.piece()) != null ? _ref.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = this.cell.toRight()) != null) && ((_ref1 = cell.piece()) != null ? _ref1.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = this.cell.up()) != null) && ((_ref2 = cell.piece()) != null ? _ref2.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = this.cell.down()) != null) && ((_ref3 = cell.piece()) != null ? _ref3.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = (_ref4 = this.cell.up()) != null ? _ref4.toLeft() : void 0) != null) && ((_ref5 = cell.piece()) != null ? _ref5.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = (_ref6 = this.cell.up()) != null ? _ref6.toRight() : void 0) != null) && ((_ref7 = cell.piece()) != null ? _ref7.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = (_ref8 = this.cell.down()) != null ? _ref8.toLeft() : void 0) != null) && ((_ref9 = cell.piece()) != null ? _ref9.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (((cell = (_ref10 = this.cell.down()) != null ? _ref10.toRight() : void 0) != null) && ((_ref11 = cell.piece()) != null ? _ref11.player : void 0) !== this.player) {
            result.push(cell);
          }
          if (!this.moved) {
            _ref12 = [0, 7];
            for (_i = 0, _len = _ref12.length; _i < _len; _i++) {
              rookColumn = _ref12[_i];
              if (((rook = this.game.cells[this.cell.row][rookColumn].piece()) != null) && rook.constructor.name === "Rook" && !rook.moved && (((function() {
                var _j, _ref13, _results;
                _results = [];
                for (i = _j = rookColumn, _ref13 = this.cell.column; rookColumn <= _ref13 ? _j < _ref13 : _j > _ref13; i = rookColumn <= _ref13 ? ++_j : --_j) {
                  if (i !== rookColumn) {
                    _results.push(this.game.cells[this.cell.row][i]);
                  }
                }
                return _results;
              }).call(this)).every(function(cell) {
                return cell.piece() == null;
              }))) {
                result.push(rookColumn < this.cell.column ? this.cell.toLeft().toLeft() : this.cell.toRight().toRight());
              }
            }
          }
          return result;
        };

        King.prototype.move = function(newCell) {
          var rook;
          if (Math.abs(newCell.column - this.cell.column) === 2) {
            rook = this.game.cells[this.cell.row][newCell.column > this.cell.column ? 7 : 0].piece();
            rook.move(newCell.column < this.cell.column ? this.cell.toLeft() : this.cell.toRight());
          }
          this.moved = true;
          return King.__super__.move.apply(this, arguments);
        };

        return King;

      })(ChessPiece);
    }
  ]);

}).call(this);

//# sourceMappingURL=King.map
