require 'cell'

describe Cell do
  A_MARK = :X
  describe 'mark a cell' do
    context 'on an empty cell' do
    let(:empty_cell) { EmptyCell.new }
      it 'returns an non epty cell when mark' do
        expect(empty_cell.mark_with(A_MARK)).to be_kind_of Cell
      end
      it 'marks a cell with the given mark' do
        new_cell = empty_cell.mark_with A_MARK
        expect(new_cell.mark).to eq A_MARK
      end
    end

    context 'on a no empty cell' do
      let(:cell) { Cell.new A_MARK }
      it "don't mark a already marked" do
        expect(cell.mark_with A_MARK).to be_nil
      end
    end
  end
end
