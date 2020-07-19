class Talk

  attr_reader :description, :length
  def initialize(description, length)
    @description = description
    @length = length
  end
end

class Track

  attr_accessor :morning_session, :afternoon_session
  def initialize
    @morning_session = Session.new(180)
    @afternoon_session = Session.new(240)
  end
end

class Session

  attr_accessor :talks, :talks_length, :length
  def initialize(length)
    @talks = []
    @talks_length = 0
    @length = length
  end
end

class Scheduler

  attr_reader :tracks
  def initialize(talks)
    @lightning_talk = lightning_talk(talks)
    @talks = talks
    schedule
  end
  
  private
  def schedule
    @current_track = "Track 1".to_sym
    @current_session = "morning_session"
    @tracks = { "Track 1": Track.new, "Track 2": Track.new }

    until @talks.empty?
      @talks.each do |talk|
        number_of_talks = @talks.length
        @track = @tracks[@current_track].instance_variable_get(("@"+@current_session))
        new_length = @track.talks_length + talk.length
        if new_length < @track.length
          add_talk(talk)
          delete_talk(talk)
        elsif new_length == @track.length
          add_talk(talk)
          delete_talk(talk)
          @current_track, @current_session = switch_track_and_slot
        end
        if number_of_talks == @talks.length
          last_added = @track.talks.pop()
          @track.talks_length -= last_added.length
          @talks << last_added
        end
      end
    end
    lightning_talk_scheduler
  end

  def lightning_talk_scheduler
    @lightning_talk.each do |talk|
      @track = @tracks[@current_track].instance_variable_get(("@"+@current_session))
      new_length = @track.talks_length + talk.length
      if new_length < @track.length
        add_talk(talk)
      end
    end
  end

  def switch_track_and_slot
    if @current_session == "morning_session"
      [@current_track, "afternoon_session"]
    else
      ["Track 2".to_sym, "morning_session"]
    end
  end

  def add_talk(talk)
    @track.talks << talk
    @track.talks_length += talk.length
  end
  
  def delete_talk(talk)
    @talks.delete talk
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
    file.each_line{|talk| @talks << process_talk(talk)}
    generate_schedule
  end

  def generate_schedule
    schedule = Scheduler.new(@talks)
    tracks = schedule.tracks
    display_schedule(tracks)
  end

  def process_talk(talk)
    description = talk
    length = talk.split.last == "minutes" ? talk.split[-2].to_i : 5
    Talk.new(description, length)
  end

  def display_schedule(tracks)
    tracks.each_pair do |key,track|
      puts "\n", key, "\n"
      date = Time.now
      time = Time.new(date.year, date.month, date.day, 9, 0)
      track.morning_session.talks.each do |talk|
        puts "#{time.strftime('%H:%M')} #{talk.description}"
        time += talk.length * 60
      end

      puts "12:00 Lunch"
      time += 60 * 60

      track.afternoon_session.talks.each do |talk|
        puts "#{time.strftime('%H:%M')} #{talk.description}"
        time += talk.length * 60
      end

      puts "17:00 Networking Session"
    end
  end
end

Conference.new("./talks.txt")
