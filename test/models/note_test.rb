require "test_helper"

describe Note do
  let(:note) { Note.new }

  it "must be valid" do
    note.must_be :valid?
  end
end
