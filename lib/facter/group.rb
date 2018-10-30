# Create a root-level unstructured fact from $facts['classification']['group']
Facter.add(:group) do
  setcode do
    Facter.value(:classification)['group']
  end
end
