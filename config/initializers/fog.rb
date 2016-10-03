CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIAWIH4BS2LLATL3Q',                        # required  
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2'                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'zachiyori'                          # required
end