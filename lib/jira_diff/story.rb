module JIRADiff

  class Story
    def initialize(story)
      unless story =~ /\w{40}|.*/
        raise ArgumentError, 'story must follow "SHA|description" format'
      end

      @sha, description      = story.split("|")
      @stories, @description = split_story description

      raise ArgumentError if @sha.nil? || @description.nil?
    end

    attr_reader :sha, :stories, :description

    def split_story(description)
      raise RuntimeError, "description cannot be blank" unless description

      stories       = []
      story_pattern = /\[?(((SRMPRT|OSMCLOUD)\-\d+)|NO-JIRA)\]?[,:\-\s]?\s*(.*)$/m
      line          = description.match(story_pattern)

      stories.push line ? line.captures[0] : "JIRA-NOT-FOUND"
      desc = (line ? line.captures[3] : description).strip

      # Perform recursion if there are multiple tickets in the description
      if desc =~ story_pattern
        new_story, new_desc = split_story desc
        stories.push new_story
        desc = new_desc
      end

      [stories.flatten, desc]
    end

    def subject
      @description.split("\n")[0].gsub(/[*:-]/, " ").strip rescue "No Description Provided"
    end

    def to_s
      "[%07.07s] %-14s - %.80s" % [sha, stories.join(", "), subject]
    end

  end
end
