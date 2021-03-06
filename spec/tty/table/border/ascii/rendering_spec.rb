# encoding: utf-8

require 'spec_helper'

describe TTY::Table::Border::ASCII, '#rendering' do

  subject { described_class.new(column_widths) }

  context 'with empty row' do
    let(:row) { TTY::Table::Row.new([]) }
    let(:column_widths) { [] }

    it 'draws top line' do
      expect(subject.top_line).to eq("++")
    end

    it 'draws middle line' do
      expect(subject.separator).to eq("++")
    end

    it 'draw bottom line' do
      expect(subject.bottom_line).to eq("++")
    end

    it 'draws row line' do
      expect(subject.row_line(row)).to eq("||")
    end
  end

  context 'with row' do
    let(:column_widths) { [2,2,2] }
    let(:row) { TTY::Table::Row.new(['a1', 'a2', 'a3']) }

    it 'draws top line' do
      expect(subject.top_line).to eq("+--+--+--+")
    end

    it 'draw middle line' do
      expect(subject.separator).to eq("+--+--+--+")
    end

    it 'draw bottom line' do
      expect(subject.bottom_line).to eq("+--+--+--+")
    end

    it 'draws row line' do
      expect(subject.row_line(row)).to eq("|a1|a2|a3|")
    end
  end

  context 'with multiline row' do
    let(:column_widths) { [2,2,2]}

    context 'with mixed data' do
      let(:row) { TTY::Table::Row.new(["a1\nb1\nc1", 'a2', 'a3']) }

      it 'draws row line' do
        expect(subject.row_line(row)).to eq <<-EOS.normalize
          |a1|a2|a3|
          |b1|  |  |
          |c1|  |  |
        EOS
      end
    end

    context 'with sparse data' do
      let(:row) { TTY::Table::Row.new(["a1\n\n", "\na2\n", "\n\na3"]) }

      it 'draws row line' do
        expect(subject.row_line(row)).to eq <<-EOS.normalize
          |a1|  |  |
          |  |a2|  |
          |  |  |a3|
        EOS
      end
    end

    context 'with empty data' do
      let(:row) { TTY::Table::Row.new(["\na1\n", "\na2\n", "\na3\n"]) }

      it 'draws row line' do
        expect(subject.row_line(row)).to eq <<-EOS.normalize
          |  |  |  |
          |a1|a2|a3|
          |  |  |  |
        EOS
      end
    end
  end
end
