require_relative 'reservation'

module Hotel

  class Room
    attr_reader :room_num, :rate, :dates
    attr_accessor :reservations

    def initialize(room_num, rate)
      @room_num = room_num
      @rate = rate
      @reservations = []
    end

    def create_reservation(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      dates = (start_date..end_date).map(&:to_s)
      reservation = Hotel::Reservation.new(start_date, end_date)

      if @reservations.length == 0
        @reservations << reservation
      else
        @reservations.each do |item|
          compare = dates & item.dates[0...-1]
          if compare.length != 0
            raise ArgumentError.new("This room is already booked.")
          end
        end
        @reservations << reservation
      end
    end

    def isAvailable(date)
      valid_date = Date.parse(date)
      if @reservations.length == 0
        return @room_num
      elsif @reservations.length != 0
        @reservations.each_index do |i|
          unless @reservations[i].dates.include? valid_date.to_s
            return @room_num
          end
        end
      end
      return nil
    end

  end #end of Room
end #end of Hotel
