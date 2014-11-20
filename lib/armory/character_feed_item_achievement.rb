require 'armory/character_feed_item'

module Armory
  class Character::Feed::Item::Achievement < Character::Feed::Item

    predicate_attr_reader_with_alias :featOfStrength, :feat_of_strength

    object_attr_reader :'Character::Achievements::Completed', :achievement, include_keys: :timestamp

  end
end
