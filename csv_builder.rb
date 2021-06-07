# frozen_string_literal: true

require './teams'
require 'csv'

TEAMS_FILE   = 'data/Teams.csv'.freeze
PLAYERS_FILE = 'data/Batting.csv'.freeze

class CsvBuilder
  def initialize
    @team = Teams.new(TEAMS_FILE)
  end

  def call(options = {})
    @options = options
    results = []
    data = []
    last_row = {}

    CSV.foreach(PLAYERS_FILE, headers: true, col_sep: ',') do |row|
      next if filter_year && row['yearID'].to_i != filter_year.to_i
      next if filter_team && team.find_by_id(row['teamID']) != filter_team

      unless last_row.empty?
        if last_row['playerID'] != row['playerID'] || last_row['yearID'] != row['yearID']
          results << calculate(data)

          data = []
        end
      end

      last_row = row
      data << row
    end
    results << calculate(data)

    results.sort_by { |header| header[3] }.reverse!
  end

  private

  attr_reader :options, :team

  def filter_year
    @filter_year ||= options.fetch(:year, false)
  end

  def filter_team
    @filter_team ||= options.fetch(:team, false)
  end

  def calculate(data = [])
    return unless data.any?

    row   = data.first
    ba    = data.collect { |csv_row| csv_row['H'].to_f / (csv_row['AB'].to_f <= 0 ? 1 : csv_row['AB'].to_f) }.reduce(&:+) / data.count
    teams = data.collect { |csv_row| find_team(csv_row['teamID']) }.reject(&:nil?).uniq

    [
      row['playerID'],
      row['yearID'].to_i,
      teams,
      ba.round(3)
    ]
  end

  def find_team(id)
    team_name = team.find_by_id(id)

    team_name
  end
end
