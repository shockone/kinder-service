#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def create_category(name, parent = nil)
  object = Category.create name: name
  object.move_to_child_of parent if parent
  object
end


def parse_categories(file_name)
  parents_stack = []
  File.open file_name do |infile|
    previous_prefix = 0
    category          = nil
    while (line = infile.gets)
      prefix = line[/\A */].length

      if prefix > previous_prefix
        parents_stack.push category if category
      elsif prefix < previous_prefix
        ((previous_prefix - prefix)/2).times {parents_stack.pop}
      end
      previous_prefix = prefix

      category = create_category line.strip, parents_stack.last
    end
  end
end

parse_categories Rails.root.join 'db', 'categories.txt'
