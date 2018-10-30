# Create a root-level unstructured fact from $facts['classification']['context']
Facter.add(:context) do
  setcode do
    Facter.value(:classification)['context']
  end
end
