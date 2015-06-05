require ['jquery', 'jquery_ujs', 'game'], ($, ujs, Game) ->

  $ ->
    game = new Game()
    game.start()
