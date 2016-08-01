// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  angular.module("app").factory("CheckerKing", [
    "CheckerPiece", "players", function(CheckerPiece, players) {
      var CheckerKing;
      return CheckerKing = (function(_super) {
        __extends(CheckerKing, _super);

        CheckerKing.$inject = ["$injector"];

        function CheckerKing($injector) {
          CheckerKing.__super__.constructor.call(this, $injector);
        }

        CheckerKing.prototype.pieceAvailableMoves = function() {
          var cell, enemy, enemyCount, result, _i, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
          result = CheckerKing.__super__.pieceAvailableMoves.apply(this, arguments);
          if (this.cell == null) {
            return result;
          }
          for (enemyCount = _i = 1; _i >= 0; enemyCount = --_i) {
            if (result.length) {
              continue;
            }
            cell = this.cell;
            while ((cell = (_ref1 = cell.up()) != null ? _ref1.toLeft() : void 0) != null) {
              if (!cell.piece() && (enemy = this.piecesBefore(cell)).length === enemyCount && ((_ref = enemy[0]) != null ? _ref.player : void 0) !== this.player) {
                result.push(cell);
              }
            }
            cell = this.cell;
            while ((cell = (_ref3 = cell.up()) != null ? _ref3.toRight() : void 0) != null) {
              if (!cell.piece() && (enemy = this.piecesBefore(cell)).length === enemyCount && ((_ref2 = enemy[0]) != null ? _ref2.player : void 0) !== this.player) {
                result.push(cell);
              }
            }
            cell = this.cell;
            while ((cell = (_ref5 = cell.down()) != null ? _ref5.toLeft() : void 0) != null) {
              if (!cell.piece() && (enemy = this.piecesBefore(cell)).length === enemyCount && ((_ref4 = enemy[0]) != null ? _ref4.player : void 0) !== this.player) {
                result.push(cell);
              }
            }
            cell = this.cell;
            while ((cell = (_ref7 = cell.down()) != null ? _ref7.toRight() : void 0) != null) {
              if (!cell.piece() && (enemy = this.piecesBefore(cell)).length === enemyCount && ((_ref6 = enemy[0]) != null ? _ref6.player : void 0) !== this.player) {
                result.push(cell);
              }
            }
          }
          return result;
        };

        return CheckerKing;

      })(CheckerPiece);
    }
  ]);

}).call(this);

//# sourceMappingURL=CheckerKing.map
