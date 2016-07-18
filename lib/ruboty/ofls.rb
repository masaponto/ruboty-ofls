# coding: utf-8
require "ruboty/ofls/version"
require "ruboty/handlers/ofls"
require 'csv'
require 'open-uri'

module Ruboty
  module Ofls

    class Shift

      def initialize(key: nil, gid: nil)
        begin
          url = 'https://docs.google.com/spreadsheets/d/' + key + '/export?format=csv&gid=' + gid
          @shift_hash = get_shift_hash(CSV.parse(open(url, "r:UTF-8")))
        rescue => e
          p e.message
        end
      end

      private
      def get_shift_hash(shift_csv)
        shift_hash = {}

        shift_csv.each do |row|
          unless row.first.nil? ||
                 row.first.match(/\d*\/\d*/).nil? then

            date          = row.first.match(/\d*\/\d*/)[0]
            one_day_shift = get_one_day_shift(row[1..-1])
            shift_hash.store(date, OneDayShift.new(row.first, one_day_shift))

          end
        end

        return shift_hash
      end

      def get_one_day_shift(shift_array)
        one_day_shift = [ shift_array[0..1].join(",").sub(/,*$/, ""),
                          shift_array[2..3].join(",").sub(/,*$/, ""),
                          shift_array[4..6].join(",").sub(/,*$/, ""),
                          shift_array[7..9].join(",").sub(/,*$/, ""),
                          shift_array[10..12].join(",").sub(/,*$/, ""),
                          shift_array[13..15].join(",").sub(/,*$/, ""),
                          shift_array[16..21].join(",").sub(/,*$/, ""),
                          shift_array[22],
                          shift_array[23],
                          shift_array[24] ]
      end

      def format_table(one_day_shift)
        str       = one_day_shift.date + "\n"
        fix_index = [ "1st",
                      "2nd",
                      "lun",
                      "3rd",
                      "4th",
                      "5th",
                      "nig",
                      "---\nmur",
                      "hig",
                      "etc" ]

        one_day_shift.shift.each_with_index do |val, i|
          str += fix_index[i] + ": " + val + "\n" unless val.nil?
        end

        return str
      end

      public
      def date_shift(date_str = "")

        if date_str.nil? || date_str.empty? then
          date_str = ""
          date     = Date.today.strftime("%m/%d").gsub(/^0|\/0/,"")

        elsif date_str.match(/^-*\d+$/) then
          date     = (Date.today + date_str.to_i).strftime("%m/%d").gsub(/^0|\/0/,"")

        elsif date_str.match(/^\d+\/\d+$/)
          date     = date_str
        end

        if @shift_hash[date].nil? then
          "no shift"
        else
          format_table(@shift_hash[date])
        end
      end

      def week_shift(week_str = "")

        if week_str.nil? || week_str.empty? then
          week_str   = ""
          week_start = - Date.today.strftime("%w").to_i + 1
          week_end   = week_start + 4

        elsif week_str.match(/^-*\d+$/) then
          week       = week_str.to_i
          week_day   = Date.today.strftime("%w").to_i - 1
          week_start = - week_day + week * 7
          week_end   = week_start + 4

        elsif week_str.match(/^\d+\/\d+$/)
          week       = (Date.parse(week_str) - Date.today).to_i
          week_day   = Date.parse(week_str).strftime("%w").to_i - 1
          week_start = - week_day + week
          week_end   = week_start + 4

        else
          return "no shift"
        end

        (week_start .. week_end).map{|date| date_shift(date.to_s)}.join("\n")

      end
    end

    class OneDayShift
      attr_reader :date, :shift
      def initialize(date, shift)
        @date  = date
        @shift = shift
      end
    end
  end
end
