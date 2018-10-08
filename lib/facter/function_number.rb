Facter.add(:function_number) do
  setcode do
    Facter.value(:classification)["number_string"]
  end
end
