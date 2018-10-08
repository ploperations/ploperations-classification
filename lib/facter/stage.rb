Facter.add(:stage) do
  setcode do
    Facter.value(:classification)["stage"]
  end
end
