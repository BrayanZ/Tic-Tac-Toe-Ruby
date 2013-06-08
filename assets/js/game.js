window.TicTacToe = window.TicTacToe || {};
TicTacToe.Game = TicTacToe.Game || {};

(function($, Game){

  New = function(options){
    this.cells = options.cells;
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
      success: function(newBoard){
        game.redrawBoard(newBoard);
      }
    });
  }

  New.prototype.redrawBoard = function(board){
    var game = this;

    $.each(board, function(position, cell){
      if(cell != null)
        $(game.cells[position]).text(cell);
    })
  }

}(jQuery, TicTacToe.Game))
