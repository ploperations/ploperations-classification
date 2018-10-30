# Create a root-level unstructured fact from $facts['classification']['function']
Facter.add(:function) do
  setcode do
    Facter.value(:classification)['function']
  end
end
