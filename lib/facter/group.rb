Facter.add(:group) do
  setcode do
    Facter.value(:classification)["group"]
  end
end
