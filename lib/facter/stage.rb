# Create a root-level unstructured fact from $facts['classification']['stage']
Facter.add(:stage) do
  setcode do
    Facter.value(:classification)['stage']
  end
end
