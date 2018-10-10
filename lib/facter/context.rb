Facter.add(:context) do
  setcode do
    Facter.value(:classification)['context']
  end
end
