# frozen_string_literal: true

require './csv_builder'

RSpec.describe CsvBuilder do

  context 'filter by year' do
    let(:options) { { year: 1903 } }
    let(:result) { described_class.new.call(options).slice(0, 3) }

    let(:sorted_data) do
      [
        ["quinnta01", 1903, ["Philadelphia Athletics"], 0.667],
        ["kerwida01", 1903, ["Cincinnati Reds"], 0.667],
        ["poundbi01", 1903, ["Cleveland Indians", "Brooklyn Dodgers"], 0.583]
      ]
    end

    it { expect(result.count).to eq 3 }
    it { expect(result).to match_array sorted_data }
  end

  context 'filter by team name' do
    let(:options) { { team: 'Troy Haymakers' } }
    let(:result) { described_class.new.call(options).slice(0, 3) }

    let(:sorted_data) do
      [
        ["gedneco01", 1872, ["Troy Haymakers"], 0.426],
        ["forceda01", 1872, ["Troy Haymakers"], 0.408],
        ["beaveed01", 1871, ["Troy Haymakers"], 0.4]
      ]
    end

    it { expect(result.count).to eq 3 }
    it { expect(result).to match_array sorted_data }
  end

  context 'filter by team name and year' do
    let(:options) { { team: 'Troy Haymakers', year: 1871 } }
    let(:result) { described_class.new.call(options) }

    let(:sorted_data) do
      [
        ["beaveed01", 1871, ["Troy Haymakers"], 0.4],
        ["kingst01", 1871, ["Troy Haymakers"], 0.396],
        ["pikeli01", 1871, ["Troy Haymakers"], 0.377],
        ["flynncl01", 1871, ["Troy Haymakers"], 0.338],
        ["cravebi01", 1871, ["Troy Haymakers"], 0.322],
        ["flowedi01", 1871, ["Troy Haymakers"], 0.314],
        ["mcmuljo01", 1871, ["Troy Haymakers"], 0.279],
        ["mcgeami01", 1871, ["Troy Haymakers"], 0.264],
        ["yorkto01", 1871, ["Troy Haymakers"], 0.255],
        ["bellast01", 1871, ["Troy Haymakers"], 0.25],
        ["connone01", 1871, ["Troy Haymakers"], 0.212],
        ["abercda01", 1871, ["Troy Haymakers"], 0.0]
      ]
    end

    it { expect(result.count).to eq 12 }
    it { expect(result).to match_array sorted_data }
  end
end
