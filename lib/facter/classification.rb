Facter.add(:classification) do
  require 'puppetops/classification'

  setcode do
    Puppetops::Classification::parse_hostname(Facter.value('hostname'))
  end
end
