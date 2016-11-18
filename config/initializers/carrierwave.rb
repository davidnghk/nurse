CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOGJE77MZCFLA2G6CQK',
    google_storage_secret_access_key: 'fdD4IfxPNo7kgD8/zvpEhEYJU2DN1uFHMVr2PiCN'
  }
  config.fog_directory = 'mos-iamges'
end