# coding: utf-8
require 'helper'

describe Armory::Data::ToonClass do

  describe "from character" do
    before do
      @toonclass = Armory::Data::ToonClass.new(:id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@toonclass.attrs).to eq(:id => 1)
      end
    end

    describe '#new' do
      it 'returns an Armory::Data::ToonClass with the correct data' do
        toonclass = Armory::Data::ToonClass.new({id: 8, mask: 128, powerType: 'mana', name: 'Mage'})
        expect(toonclass).to be_a Armory::Data::ToonClass
        expect(toonclass.id).to be_a Integer
        expect(toonclass.id).to eq(8)
        expect(toonclass.mask).to be_a Integer
        expect(toonclass.mask).to eq(128)
        expect(toonclass.power_type).to be_a String
        expect(toonclass.power_type).to eq('mana')
        expect(toonclass.name).to be_a String
        expect(toonclass.name).to eq('Mage')
      end
    end

  end


  describe "from talent_data" do

    before do
      @talent_class_data = {
          :id => 1,
          :class => 'Warrior',
          :glyphs => [ { glyph: 483, item: 43395, name: "Glyph of Mystic Shout", typeId: 1 } ],
          :talents => [
                        [
                          [{
                              tier: 0,
                              column: 1,
                              spell: {
                                  id: 103826,
                                  name: "Juggernaut",
                                  icon: "ability_warrior_bullrush",
                                  description: "You can Charge every 12 sec instead of every 20 sec.",
                                  castTime: "Passive"
                              },
                              spec: {
                                  name: "Fury",
                                  role: "DPS",
                                  backgroundImage: "bg-warrior-fury",
                                  icon: "ability_warrior_innerrage",
                                  description: "",
                                  order: 1
                              }
                          }, {

                              tier: 0,
                              column: 1,
                              spell: {
                                  id: 103827,
                                  name: "Juggernaut2",
                                  castTime: "Passive"
                              },
                              # No spec, which means default spell for this tier
                          }]]],
          :specs => [ { name: "Arms", role: "DPS", order: 0 } ],
          :petSpecs => [ { name: "Ferocity", order: 0 }, { name: "Tenacity", order: 1 } ],
      }
      @data_class = Armory::Data::ToonClass.new(@talent_class_data)
    end

    describe '#new' do
      it 'returns an Armory::Data::ToonClass with the correct data' do
        expect(@data_class).to be_a Armory::Data::ToonClass
        expect(@data_class.id).to be_a Integer
        expect(@data_class.id).to eq(1)
        expect(@data_class.classname).to be_a String
        expect(@data_class.classname).to eq("Warrior")
      end

      it 'correctly parses glyphs' do
        expect(@data_class.glyphs).to be_a Array
        expect(@data_class.glyphs.first).to be_a Armory::Data::Glyph
        expect(@data_class.glyphs.first.id).to eq(483)
        expect(@data_class.glyphs.first.name).to eq('Glyph of Mystic Shout')
      end

      it 'correctly parses talents' do
        expect(@data_class.talents).to be_a Array
        expect(@data_class.talents.first).to be_a Array
        expect(@data_class.talents.first.first).to be_a Array
        first_talent = @data_class.talents.first.first.first
        expect(first_talent).to be_a Armory::Data::Talent
        expect(first_talent.tier).to eq(0)
        expect(first_talent.column).to eq(1)
        expect(first_talent.spell).to be_a Armory::Data::Spell
        expect(first_talent.spell.id).to eq(103826)
        expect(first_talent.spell.name).to eq("Juggernaut")
        expect(first_talent.spec).to be_a Armory::Data::Spec
        expect(first_talent.spec.name).to eq("Fury")
      end

      it 'finds missing spec (ie default)' do
        second_talent = @data_class.talents.first.first[1]
        expect(second_talent).to be_a Armory::Data::Talent
        expect(second_talent.tier).to eq(0)
        expect(second_talent.column).to eq(1)
        expect(second_talent.spell).to be_a Armory::Data::Spell
        expect(second_talent.spell.id).to eq(103827)
        expect(second_talent.spec).to eq(nil)
      end

      it 'correctly parses specs' do
        expect(@data_class.specs).to be_a Array
        expect(@data_class.specs.first).to be_a Armory::Data::Spec
        expect(@data_class.specs.first.name).to eq("Arms")
        expect(@data_class.specs.first.role).to eq("DPS")
        expect(@data_class.specs.first.order).to eq(0)
      end

      it 'correctly parses pet specs' do
        expect(@data_class.pet_specs).to be_a Array
        expect(@data_class.pet_specs.first).to be_a Armory::Data::Spec
        expect(@data_class.pet_specs.first.name).to eq("Ferocity")
        expect(@data_class.pet_specs.first.order).to eq(0)
      end
    end
  end

  describe '#==' do
    it 'returns true when ids are the same' do
      item1 = Armory::Data::ToonClass.new({ id: 1 })
      item2 = Armory::Data::ToonClass.new({ id: 1 })
      expect(item1 == item2).to be true
    end
    it 'returns false when ids are different' do
      item1 = Armory::Data::ToonClass.new({ id: 1 })
      item2 = Armory::Data::ToonClass.new({ id: 2 })
      expect(item1 == item2).to be false
    end
  end




end
