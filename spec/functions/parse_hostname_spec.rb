require 'spec_helper'

describe 'classification::parse_hostname' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      context 'with v2 hostname with context' do
        it {
          is_expected.to run.with_params(
            'pe-lb-spectesting-prod-1',
          ).and_return(
            'hostname' => 'pe-lb-spectesting-prod-1',
            'parts' => [
              'pe',
              'lb',
              '1',
              'spectesting',
              'prod',
              nil,
            ],
            'version' => 2,
            'group' => 'pe',
            'function' => 'lb',
            'number' => 1,
            'number_string' => '1',
            'context' => 'spectesting',
            'stage' => 'prod',
            'id' => nil,
          )
        }
      end
      context 'with v2 hostname without context' do
        it {
          is_expected.to run.with_params(
            'pe-lb-prod-1',
          ).and_return(
            'hostname' => 'pe-lb-prod-1',
            'parts' => [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              nil,
            ],
            'version' => 2,
            'group' => 'pe',
            'function' => 'lb',
            'number' => 1,
            'number_string' => '1',
            'context' => '',
            'stage' => 'prod',
            'id' => nil,
          )
        }
      end
      context 'with v2 hostname with id' do
        it {
          is_expected.to run.with_params(
            'pe-lb-prod-1-abc123iou',
          ).and_return(
            'hostname' => 'pe-lb-prod-1-abc123iou',
            'parts' => [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              'abc123iou',
            ],
            'version' => 2,
            'group' => 'pe',
            'function' => 'lb',
            'number' => 1,
            'number_string' => '1',
            'context' => '',
            'stage' => 'prod',
            'id' => 'abc123iou',
          )
        }
      end
      context 'with v1 hostname' do
        it {
          is_expected.to run.with_params(
            'pe-lb1-prod',
          ).and_return(
            'hostname' => 'pe-lb1-prod',
            'parts' => [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              '',
            ],
            'version' => 1,
            'group' => 'pe',
            'function' => 'lb',
            'number' => 1,
            'number_string' => '1',
            'context' => '',
            'stage' => 'prod',
            'id' => '',
          )
        }
      end
      context 'with v0 hostname with number and stage' do
        it {
          is_expected.to run.with_params(
            'pelb1-prod',
          ).and_return(
            'hostname' => 'pelb1-prod',
            'parts' => [
              'pelb',
              '',
              '',
              '',
              'prod',
              '',
            ],
            'version' => 0,
            'group' => 'pelb',
            'function' => '',
            'number' => nil,
            'number_string' => '',
            'context' => '',
            'stage' => 'prod',
            'id' => '',
          )
        }
      end
      context 'with v0 hostname with number and without stage' do
        it {
          is_expected.to run.with_params(
            'pelb1',
          ).and_return(
            'hostname' => 'pelb1',
            'parts' => [
              'pelb',
              '',
              '',
              '',
              '',
              '',
            ],
            'version' => 0,
            'group' => 'pelb',
            'function' => '',
            'number' => nil,
            'number_string' => '',
            'context' => '',
            'stage' => '',
            'id' => '',
          )
        }
      end
      context 'with v0 hostname with stage without number' do
        it {
          is_expected.to run.with_params(
            'pelb-prod',
          ).and_return(
            'hostname' => 'pelb-prod',
            'parts' => [
              'pelb',
              '',
              '',
              '',
              'prod',
              '',
            ],
            'version' => 0,
            'group' => 'pelb',
            'function' => '',
            'number' => nil,
            'number_string' => '',
            'context' => '',
            'stage' => 'prod',
            'id' => '',
          )
        }
      end
      context 'with v0 hostname with only letters' do
        it {
          is_expected.to run.with_params(
            'pelb',
          ).and_return(
            'hostname' => 'pelb',
            'parts' => [
              'pelb',
              '',
              '',
              '',
              '',
              '',
            ],
            'version' => 0,
            'group' => 'pelb',
            'function' => '',
            'number' => nil,
            'number_string' => '',
            'context' => '',
            'stage' => '',
            'id' => '',
          )
        }
      end
    end
  end
end
