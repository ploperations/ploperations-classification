Facter.add(:function) do
  setcode do
    Facter.value(:classification)['function']
  end
end
