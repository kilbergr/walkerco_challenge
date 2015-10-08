#!/usr/bin/env ruby -wKU
require "pry"
class Node
  attr_accessor :value, :next_node
  def initialize(value=nil)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  attr_accessor :head, :tail, :length
  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end


  def add(value)
   
    if @length == 0
      @head = Node.new(value)
      @tail = @head
    else
       @tail.next_node = Node.new(value)
       @tail = @tail.next_node
    end
       @length+=1
  end

  def remove(value)
    current = @head
    while current.next_node
      if current.next_node.value == value
        current.next_node = current.next_node.next_node
        return @head
      else
        current = current.next_node
      end
    end
    return nil
  end

  def shift()
    current = @head
    @head = current.next_node
    # show new LL
    @head
  end

  def unshift(value)
    current = @head
    @head.value = value
    @head.next_node = current
    # show new LL
    @head
  end

  def find(value)
    current = @head
    while current.next_node
      if current.value == value
        return current
      else current = current.next_node
      end
    end
    # if not found
    nil
  end

  def reverseUgly
    # I think this is a place for a hash but in the interest of time...will come back if possible
    current = @head
    revArray = []
    # get all data into array
    while current
      revArray.push(current.value)
      current = current.next_node
    end

    i = revArray.length-1
    # start with data that had been in last node
    @head = Node.new(revArray[i])
    current = @head
    i-=1
    while i > 0
      while current.next_node
        current = current.next_node
        i -= 1
      end
      current.next_node = Node.new(revArray[i])
    end
    # return reversed array
    @head
  end

end


=begin
  ############################
  RSPEC CONFIG AND TESTS BELOW
  ############################
=end

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
  config.default_formatter = 'doc'
end

describe LinkedList do
  it "has a head" do
    ll = LinkedList.new
    expect(ll.head).to eql(nil)
    ll.add(1)
    expect(ll.head.value).to eq(1)
  end
  

  it "has a tail" do
    ll = LinkedList.new
    ll.add(1)
    expect(ll.tail.value).to eq(1)
    ll.add(2)
    expect(ll.tail.value).to eql(2)
    expect(ll.tail.next_node).to be_nil
  end

  it "adds a value" do
    ll = LinkedList.new
    ll.add(1)
    ll.add(2)
    ll.add(3)
    expect(ll.head.value).to eql(1)
    expect(ll.tail.value).to eql(3)
  end

  it "finds a node" do
    ll = LinkedList.new
    10.times do |i|
      ll.add(i)
    end
    node_4 =  ll.find(4)
    expect(node_4.value).to eql(4)
    node_5 =  ll.find(5)
    expect(node_5.value).to eql(5)
  end

  it "removes a node" do
    ll = LinkedList.new
    10.times do |i|
      ll.add(i)
    end
    node_4 =  ll.find(4)
    expect(node_4.next_node.value).to eql(5)
    ll.remove(5)
    expect(node_4.next_node.value).to eql(6)
  end

  it "has a length" do
    ll = LinkedList.new
    expect(ll.length).to eql(0)

    ll.add("thefirst")
    expect(ll.length).to eql(1)

    10.times do |i|
      ll.add(i)
    end
    expect(ll.length).to eql(11)
  end
end
