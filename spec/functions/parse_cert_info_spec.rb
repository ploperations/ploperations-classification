require 'spec_helper'

describe 'classification::parse_cert_info' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      context 'with regular hostname' do
        let(:node) { 'pe-lb-spectesting-prod-1.ops.example.com' }

        it {
          is_expected.to run.with_params(
            'pe-lb-spectesting-prod-1.ops.example.com',
          ).and_return(
            'certname'      => 'pe-lb-spectesting-prod-1.ops.example.com',
            'cert_hostname' => 'pe-lb-spectesting-prod-1',
            'cert_domain'   => 'ops.example.com',
          )
        }
      end
      context 'with old AWS hostname' do
        let(:node) { 'i-abc123def456.ops.example.com' }

        it {
          is_expected.to run.with_params(
            'pe-lb-spectesting-prod-1.ops.example.com',
          ).and_return(
            'certname'      => 'i-abc123def456.ops.example.com',
            'cert_hostname' => 'i-abc123def456',
            'cert_domain'   => 'ops.example.com',
          )
        }
      end
    end
  end
end
