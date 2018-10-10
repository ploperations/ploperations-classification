Facter.add(:number_string) do
  setcode do
    Facter.value(:classification)['number_string']
  end
end
