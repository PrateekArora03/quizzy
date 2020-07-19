class Talk

  attr_reader :description, :length
  def initialize(description, length)
    @description = description
    @length = length
  end
end

class Track

  attr_accessor :morning_slot, :afternoon_slot
  def initialize
    @morning_slot = Slot.new(180)
    @afternoon_slot = Slot.new(240)
  end
end

class Slot

  attr_accessor :talks, :talks_length, :slot_length
  def initialize(slot_length)
    @talks = []
    @talks_length = 0
    @slot_length = slot_length
  end
end

class Schedule

  attr_reader :tracks
  def initialize(talks)
    @lightning_talk = lightning_talk(talks)
    @talks = talks
    @tracks = { "Track 1": Track.new, "Track 2": Track.new }
    scheduler
  end

  private
  def scheduler
    current_track = "Track 1".to_sym
    current_slot = "morning_slot"

    until @talks.empty?
      @talks.each do |talk|
        number_of_talks = @talks.length
        track = @tracks[current_track].instance_variable_get(("@"+current_slot))
        new_length = track.talks_length + talk.length
        if new_length < track.slot_length
          add_talk(track, talk)
          delete_talk(@talks, talk)
        elsif new_length == track.slot_length
          add_talk(track, talk)
          delete_talk(@talks, talk)
          current_track, current_slot = switch_track_and_slot(current_track, current_slot)
        end
        if number_of_talks == @talks.length
          last_added = track.talks.pop()
          track.talks_length -= last_added.length
          @talks << last_added
        end
      end
    end
    lightning_talk_scheduler(current_track, current_slot)
  end

  def lightning_talk_scheduler(current_track, current_slot)
    @lightning_talk.each do |talk|
      track = @tracks[current_track].instance_variable_get(("@"+current_slot))
      new_length = track.talks_length + talk.length
      if new_length < track.slot_length
        add_talk(track, talk)
      end
    end
  end

  def switch_track_and_slot(current_track, current_slot)
    if current_slot == "morning_slot"
      [current_track, "afternoon_slot"]
    else
      ["Track 2".to_sym, "morning_slot"]
    end
  end

  def add_talk(track, talk)
    track.talks << talk
    track.talks_length += talk.length
  end
  
  def delete_talk(talks, talk)
    talks.delete talk
  end

  def lightning_talk(talks)
    lightning_talk = talks.select { |talk| talk.length == 5 }
    lightning_talk.each do |talk|
      talks.delete talk
    end
    lightning_talk
  end
end

class Conference

  def initialize(file_name)
    @talks = []
    @file_name = file_name
    get_talks
  end

  private
  def get_talks
    file = File.open(@file_name, 'r')
    file.each_line{|talk| @talks << create_talk(talk)}
    schedule = Schedule.new(@talks)
    tracks = schedule.tracks
    display_schedule(tracks)
  end

  def create_talk(talk)
    description = talk
    length = talk.split.last == "minutes" ? talk.split[-2].to_i : 5
    Talk.new(description, length)
  end

  def display_schedule(tracks)
    tracks.each_pair do |key,track|
      puts "\n", key, "\n"
      date = Time.now
      time = Time.new(date.year, date.month, date.day, 9, 0)
      track.morning_slot.talks.each do |talk|
        puts "#{time.strftime('%H:%M')} #{talk.description}"
        time += talk.length * 60
      end

      puts "12:00 Lunch"
      time += 60 * 60

      track.afternoon_slot.talks.each do |talk|
        puts "#{time.strftime('%H:%M')} #{talk.description}"
        time += talk.length * 60
      end

      puts "17:00 Networking Session"
    end
  end
end

Conference.new("./talks.txt")
