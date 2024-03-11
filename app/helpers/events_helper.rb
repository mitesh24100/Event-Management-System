module EventsHelper
  def options_for_available_rooms(date, start_time, end_time)
    taken_rooms = Event.where(date: date)
                       .where.not("end_time <= ? OR start_time >= ?", start_time, end_time)
                       .pluck(:room_id)
    available_rooms = Room.where.not(id: taken_rooms)
    available_rooms.map { |room| [room.id, room.id] }
  end
end
