require 'cell'

describe Cell do
  A_MARK = :X
  describe 'mark a cell' do
    it 'marks a cell with the given mark' do
      cell = described_class.new
      cell.mark_with A_MARK
      expect(cell.mark).to eq A_MARK
    end
  end
end
