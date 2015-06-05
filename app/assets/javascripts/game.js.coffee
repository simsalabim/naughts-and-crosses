define ['game'], (Game) ->
  class Game
    constructor: ->
      @$el = $(".board")

    isCompleted: -> !!@data.completed

    winnerRow: -> @data.winner_row

    activePlayer: -> @data.active_player

    start: ->
      return if @$el.length < 1

      @data = gon.game

      @highlight @winnerRow()
      @waitForUserInput()
      setInterval @botNextTurn, 1000

    highlight: ->
      if @winnerRow().length > 0
        @$el.addClass("with-winner")
        for cell in @winnerRow()
          @cellAt(cell.row, cell.column).addClass("winner")

    cellAt: (row, column) ->
      @$el.find(".cell[data-row=#{row}][data-column=#{column}]")

    botNextTurn: =>
      if $.active == 0 && @activePlayer().strategy != "Human" && !@isCompleted()
        @nextTurn()

    waitForUserInput: ->
      @$el.find(".cell").on "click", (e) =>
        return if @isCompleted()

        if @activePlayer().strategy == "Human" && $.active == 0
          $td = $(e.currentTarget)
          previousToken = $td.data("token")
          return if previousToken != undefined && previousToken.trim() != ""

          $td.attr("data-token", @activePlayer().token)

          cell = $td.data()

          @nextTurn
            row: cell.row
            column: cell.column
            token: @activePlayer().token
            previousToken: previousToken


    nextTurn: (move_data = {}) =>
      @moveData = move_data
      $.ajax
        url: "/games/#{@data.id}/moves"
        type: "POST"
        data:
          move: @moveData
        dataType: "json"
        success: (data) =>
          cell = data.move

          @cellAt(cell.row, cell.column).attr("data-token", cell.token)
          @data = data.game
          @highlight(@winnerRow())
        error: (xhr, status, err) =>
          console.log status, err.toString()

          if @moveData.previousToken == undefined
            @cellAt(@moveData.row, @moveData.column).removeAttr("data-token")
          else
            @cellAt(@moveData.row, @moveData.column).attr("data-token", @moveData.previousToken)
