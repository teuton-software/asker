# encoding: utf-8

describe "T1U1 Activity 1" do
	cases=[1,2,3]
	
	cases.each do |c| 
		
		context "Case [#{c}]" do
			max=10
			it "is less than #{max}" do
				expect(c).to be <= max
			end
		end
	end
end
