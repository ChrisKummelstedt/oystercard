require 'station'

describe Station do

let(:a_station){ described_class.new "Old Town", 1}
  it "knows which station zone is associated with it" do
    expect(a_station.zone).to eq 1
  end

  it "knows which station zone is associated with it" do
    expect(a_station.name).to eq "Old Town"
  end

end
