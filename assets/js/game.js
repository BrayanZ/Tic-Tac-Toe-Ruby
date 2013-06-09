window.TicTacToe = window.TicTacToe || {};
TicTacToe.Game = TicTacToe.Game || {};

(function($, Game){

  New = function(options){
    this.cells        = options.cells;
    this.messageField = options.messageField;
  }

  Game.New = New;

  New.prototype.bind = function(){
    this.bindCellsFunction();
  }

  New.prototype.bindCellsFunction = function(){
    var game = this;
    game.cells.click(function(event){
      event.preventDefault();

      var cellPosition = $(this).data('position');
      game.postJSON(cellPosition);
    });
  }

  New.prototype.postJSON = function(cellPosition){
    var game = this;

    $.ajax({
      dataType: 'json',
      type: 'POST',
      url: '/play_cell',
      data: { cell: cellPosition },
      success: function(gameStatus){
        game.redrawBoard(gameStatus.board);
        game.printStatus(gameStatus.is_game_over, gameStatus.winner);
      }
    });
  }

  New.prototype.printStatus = function(is_game_over, winner){
    if(is_game_over){
      this.messageGameOver(winner);
      this.disableCells();
    }
  }

  New.prototype.disableCells = function(){
    this.cells.removeAttr('href');
    this.cells.unbind('click');
  }

  New.prototype.messageGameOver = function(winner){
    if(winner != null)
      return this.messageField.text('Winner player ' + winner);
    this.messageField.text('Game Over');
  }

  New.prototype.redrawBoard = function(board){
    var game = this;

    $.each(board, function(position, cell){
      if(cell != null)
        $(game.cells[position]).text(cell);
    })
  }

}(jQuery, TicTacToe.Game))
