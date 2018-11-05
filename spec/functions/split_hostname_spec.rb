require 'spec_helper'

describe 'classification::split_hostname' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      context 'with v2 hostname with context' do
        it {
          is_expected.to run.with_params(
            'pe-lb-spectesting-prod-1',
          ).and_return(
            [
              'pe',
              'lb',
              '1',
              'spectesting',
              'prod',
              nil,
            ],
          )
        }
      end
      context 'with v2 hostname without context' do
        it {
          is_expected.to run.with_params(
            'pe-lb-prod-1',
          ).and_return(
            [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              nil,
            ],
          )
        }
      end
      context 'with v2 hostname with id' do
        it {
          is_expected.to run.with_params(
            'pe-lb-prod-1-abc123iou',
          ).and_return(
            [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              'abc123iou',
            ],
          )
        }
      end
      context 'with v1 hostname' do
        it {
          is_expected.to run.with_params(
            'pe-lb1-prod',
          ).and_return(
            [
              'pe',
              'lb',
              '1',
              '',
              'prod',
              '',
            ],
          )
        }
      end
      context 'with v0 hostname with number and stage' do
        it {
          is_expected.to run.with_params(
            'pelb1-prod',
          ).and_return(
            [
              'pelb',
              '',
              '',
              '',
              'prod',
              '',
            ],
          )
        }
      end
      context 'with v0 hostname with number and without stage' do
        it {
          is_expected.to run.with_params(
            'pelb1',
          ).and_return(
            [
              'pelb',
              '',
              '',
              '',
              '',
              '',
            ],
          )
        }
      end
      context 'with v0 hostname with stage and without number' do
        it {
          is_expected.to run.with_params(
            'pelb-prod',
          ).and_return(
            [
              'pelb',
              '',
              '',
              '',
              'prod',
              '',
            ],
          )
        }
      end
      context 'with v0 hostname with only letters' do
        it {
          is_expected.to run.with_params(
            'pelb',
          ).and_return(
            [
              '',
              '',
              '',
              '',
              '',
              '',
            ],
          )
        }
      end
    end
  end
end
