angular.module("app").config \

  class AppConfig
    @$inject: ["$routeProvider"]
    constructor: ($routeProvider) ->
      $routeProvider

      .when "/",
          templateUrl: "app/pages/gameList/gameListView.html"
          controller: "GameListController"
          controllerAs: "vm"

      .when "/chess",
          templateUrl: "app/pages/game/gameView.html"
          controller: "GameController"
          controllerAs: "vm"
          resolve:
            gameName: -> "Chess"
            gameRules: "chessRules"

      .when "/checkers",
          templateUrl: "app/pages/game/gameView.html"
          controller: "GameController"
          controllerAs: "vm"
          resolve:
            gameName: -> "Checkers"
            gameRules: "checkersRules"

      .when "/reversi",
          templateUrl: "app/pages/game/gameView.html"
          controller: "GameController"
          controllerAs: "vm"
          resolve:
            gameName: -> "Reversi"
            gameRules: "reversiRules"

      .when "/ugolki",
          templateUrl: "app/pages/game/gameView.html"
          controller: "GameController"
          controllerAs: "vm"
          resolve:
            gameName: -> "Ugolki"
            gameRules: "ugolkiRules"
