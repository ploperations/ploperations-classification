# Create a root-level unstructured fact from $facts['classification']['number_string']
Facter.add(:number_string) do
  setcode do
    Facter.value(:classification)['number_string']
  end
end
