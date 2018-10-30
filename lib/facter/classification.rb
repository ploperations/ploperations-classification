# Get the hostname from Facter and parse it into a structured fact
Facter.add(:classification) do
  require 'ploperations/classification'

  setcode do
    Ploperations::Classification.parse_hostname(Facter.value('hostname'))
  end
end
