require 'spec_helper'

describe 'classification::validate_facts' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      context 'with valid facts' do
        let(:node) { 'pe-lb-spectesting-prod-1.ops.example.com' }

        it {
          is_expected.to run.with_params(
            {
              'certname' => 'pe-lb-spectesting-prod-1.ops.example.com',
              'hostname' => 'pe-lb-spectesting-prod-1',
              'fqdn'     => 'pe-lb-spectesting-prod-1.ops.example.com',
              'domain'   => 'ops.example.com',
            },
            {
              'certname' => 'pe-lb-spectesting-prod-1.ops.example.com',
              'hostname' => 'pe-lb-spectesting-prod-1',
              'fqdn'     => 'pe-lb-spectesting-prod-1.ops.example.com',
              'domain'   => 'ops.example.com',
            },
            [
              'certname',
              'hostname',
              'fqdn',
              'domain',
            ],
          ).and_return(
            [],
          )
        }
      end
      context 'with invalid facts' do
        let(:node) { 'pe-lb-spectesting-prod-1.ops.example.com' }

        it {
          is_expected.to run.with_params(
            {
              'certname' => 'foo.ops.example.com',
              'hostname' => 'foo',
              'fqdn'     => 'foo.ops.example.com',
              'domain'   => 'ops.example.com',
            },
            {
              'certname' => 'pe-lb-spectesting-prod-1.ops.example.com',
              'hostname' => 'pe-lb-spectesting-prod-1',
              'fqdn'     => 'pe-lb-spectesting-prod-1.ops.example.com',
              'domain'   => 'ops.example.com',
            },
            [
              'certname',
              'hostname',
              'fqdn',
              'domain',
            ],
          ).and_return(
            [
              "    certname: 'foo.ops.example.com' != 'pe-lb-spectesting-prod-1.ops.example.com'",
              "    hostname: 'foo' != 'pe-lb-spectesting-prod-1'",
              "    fqdn: 'foo.ops.example.com' != 'pe-lb-spectesting-prod-1.ops.example.com'",
            ],
          )
        }
      end
    end
  end
end
