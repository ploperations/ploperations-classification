require 'spec_helper'

describe 'classification::test_fact_difference_array' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      context 'with errors' do
        it {
          is_expected.to run.with_params(
            [
              "    hostname: 'bad' != 'good'",
              "    domain: 'foo' != 'bar'",
            ],
          ).and_raise_error(
            # I would like to also match on the error message using a regex but couldn't get it working.
            Puppet::PreformattedError,
          )
        }
      end
      context 'without errors' do
        it {
          is_expected.to run.with_params(
            [],
          ).and_return(
            true,
          )
        }
      end
    end
  end
end
