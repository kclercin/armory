require 'armory/base'
require 'armory/modifiable'
require 'armory/data/toon_class'

module Armory
  class Character < Armory::Base
    include Armory::Modifiable

    attr_reader :name, :battlegroup, :level, :achievementPoints, :thumbnail, :calcClass
    attr_reader :totalHonorableKills

    alias_method :achievement_points, :achievementPoints
    alias_method :calc_class, :calcClass
    alias_method :total_honorable_kills, :totalHonorableKills

    # loaded from Guild
    attr_reader :rank, :guildRealm
    alias_method :guild_realm, :guildRealm

    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :'Data::ToonClass', :class, target_alias: :id
    object_attr_reader :'Data::Race', :race, target_alias: :id
    object_attr_reader :'Data::Gender', :gender, target_alias: :id

    object_attr_reader :'Data::Achievements', :achievements
    object_attr_reader :'Character::Appearance', :appearance
    object_attr_reader_as_array :'Data::Feed::Item', :feed
    object_attr_reader :Guild, :guild
    object_attr_reader :'Character::Items', :items
    object_attr_reader :'Character::Mounts', :mounts
    object_attr_reader :'Character::Pets', :pets
    object_attr_reader :'Character::PvP', :pvp, extra_key: :brackets
    object_attr_reader_as_array :'Character::Talents', :talents
    
    # loaded from Guild
    object_attr_reader :'Data::Spec', :spec

    # object_attr_reader_as_array :'Data::Raid', :progression, extra_key: :raids - replaced by below
    def progression
      @collection
    end
    memoize :progression

    def progression_hash
      @collection_hash
    end
    memoize :progression_hash

    def initialize(region, attrs = {})
      super

      if @attrs.fetch(:progression,{}).fetch(:raids,[]).count > 0
        @collection = @attrs[:progression][:raids].collect do |data|
          Data::Raid.new(data)
        end
        # Create hash keyed on achievement id
        @collection_hash = Hash[@collection.map {|a| [ a.id, a ] }]
      end
    end

  end
end
