#require 'armory/meta_methods.rb'
#require 'armory/base.rb'
#require 'armory/identity.rb'
#require 'equalizer'
#require 'memoizable'
#require 'armory/enumerable'
#require 'armory/timestamp'

module Armory
  module EXTRAMODULE
    class NAME < Armory::MetaMethods | Armory::Base | Armory::Identity
    #include Armory::Enumerable
    #include Memoizable
    #include Equalizer.new(:item_id)
    #include Timestamp

    #attr_reader :name, :qualityId
    #alias_method :quality_id, :qualityId

    #predicate_attr_reader :showCloak
    #predicate_attr_reader_with_alias :showCloak, :show_cloak

    #object_attr_reader :Item, :item, method_alias: key1, target_alias: nil, include_keys: IncludeKey.new(symbol: :timestamp)
    #object_attr_reader_as_array :'Armory::Data::Spec', :petSpecs, meth_alias: :pet_specs, extra_key: :raids


    end
  end
end
