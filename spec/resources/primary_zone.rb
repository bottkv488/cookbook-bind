require 'spec_helper'

describe 'adding primary zones' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos', version: '7.3.1611', step_into: %w(bind_config bind_primary_zone)
    ).converge('bind_test::spec_primary_zone')
  end

  it 'uses the custom resource' do
    expect(chef_run).to create_bind_primary_zone('example.com')
  end

  it 'will copy the zone file from the test cookbook' do
    expect(chef_run).to render_file('/var/named/primary/db.example.com').with_content { |content|
      expect(content).to include '$ORIGIN example.com.'
    }
  end

  it 'will place the config in the named config' do
    expect(chef_run).to render_file('/etc/named.conf').with_content { |content|
      expect(content).to include 'zone "example.com" IN {'
      expect(content).to include 'file "primary/db.example.com";'
    }
  end
end
