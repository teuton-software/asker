# encoding: utf-8

require_relative '../lib/question'

describe Question do
	let(:question) { Question.new }
	context "has attributes" do
		it "comment" do
			expect(question).to respond_to :comment
			expect(question.comment).to be_nil
			question.comment="Random comment"
			expect(question.comment).to be_eql "Random comment"
		end
		it "name" do
			expect(question).to respond_to :name
			expect(question.name).to be_nil
			question.name="Random name"
			expect(question.name).to be_eql "Random name"
		end
		it "text" do
			expect(question).to respond_to :text
			expect(question.text).to be_eql ''
			question.text="Random text"
			expect(question.text).to be_eql "Random text"
		end
		it "good" do
			expect(question).to respond_to :good
			expect(question.good).to be_nil
			question.good="Random good"
			expect(question.good).to be_eql "Random good"
		end
	end
	
	describe "has Array attributes" do
		it "bads Array" do
			expect(question).to respond_to :bads
			expect(question.bads).to be_eql []
			question.bads << "bad1"
			question.bads << "bad2"
			question.bads << "bad3"
			expect(question.bads).to match_array ["bad1","bad2","bad3"]
		end

		it "matching array" do
			expect(question).to respond_to :matching
			expect(question.matching).to be_eql []
			question.matching << [ 1, "bad1" ]
			question.matching << [ 2, "bad2" ]
			question.matching << [ 3, "bad3" ]
			expect(question.matching).to match_array [ [1,"bad1"], [2,"bad2"], [3,"bad3"]]
		end
	end

	describe "has type management" do
		it "default and changed values" do
			expect(question).to respond_to :set_choice
			expect(question).to respond_to :set_match
			expect(question).to respond_to :set_boolean
			
			expect(question.type).to be_eql :choice
			question.set_match
			expect(question.type).to be_eql :match
			question.set_boolean
			expect(question.type).to be_eql :boolean
			question.set_choice
			expect(question.type).to be_eql :choice
		end
	end

	describe "#to_s method" do
		it "methods" do
			expect(question).to respond_to :to_s
		end
	end
end
